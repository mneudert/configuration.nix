with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "template-shell-kibana6";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    PROJECT_ROOT="$(pwd)"
    PID_KIBANA="$PROJECT_ROOT/runtime/kibana6/kibana.pid"

    function finish {
      [ -f "$PID_KIBANA" ] && {
        sudo -u nolimits kill -QUIT "$(cat "$PID_KIBANA")"
        sudo -u nolimits rm -f "$PID_KIBANA"
      }
    }

    [ ! -d './runtime/elasticsearch6' ] && {
      mkdir -p runtime/kibana6

      chmod 774 runtime/kibana6
    }

    sudo -u nolimits \
        BABEL_CACHE_PATH="$PROJECT_ROOT/runtime/kibana6/.babelcache.json" \
        DATA_PATH="$PROJECT_ROOT/runtime/kibana6/" \
        kibana -c "$PROJECT_ROOT/runtime/kibana6/kibana.yml" &

    trap finish EXIT

    export PS1="[${name}:\w]$ "
  '';

  kibana6 = pkgs.callPackage /data/projects/private/configuration.nix/packages/kibana6 { nodejs = nodejs-6_x; };

  buildInputs = [
    kibana6
  ];
}
