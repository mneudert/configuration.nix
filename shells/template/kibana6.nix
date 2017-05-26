with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "template-shell-kibana6";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    PROJECT_ROOT="$(pwd)"
    PID_KIBANA="$PROJECT_ROOT/runtime/kibana/kibana.pid"

    function finish {
      [ -f "$PID_KIBANA" ] && {
        sudo -u nolimits kill -QUIT "$(cat "$PID_KIBANA")"
        sudo -u nolimits rm -f "$PID_KIBANA"
      }
    }

    [ ! -d './runtime/elasticsearch' ] && {
      mkdir -p runtime/kibana

      chmod 774 runtime/kibana
    }

    sudo -u nolimits \
        BABEL_CACHE_PATH="$PROJECT_ROOT/runtime/kibana/.babelcache.json" \
        DATA_PATH="$PROJECT_ROOT/runtime/kibana/" \
        kibana -c "$PROJECT_ROOT/runtime/kibana/kibana.yml" &

    trap finish EXIT

    export PS1="[${name}:\w]$ "
  '';

  kibana6 = pkgs.callPackage /data/projects/private/configuration.nix/packages/kibana6 { nodejs = nodejs-6_x; };

  buildInputs = [
    kibana6
  ];
}
