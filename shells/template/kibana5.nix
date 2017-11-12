with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "template-shell-kibana5";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    PROJECT_ROOT="$(pwd)"
    PID_KIBANA="$PROJECT_ROOT/runtime/kibana5/kibana.pid"

    function finish {
      [ -f "$PID_KIBANA" ] && {
        sudo -u nolimits kill -QUIT "$(cat "$PID_KIBANA")"
        sudo -u nolimits rm -f "$PID_KIBANA"
      }
    }

    [ ! -d './runtime/elasticsearch5' ] && {
      mkdir -p runtime/kibana5

      chmod 775 runtime/kibana5

      sed "s|{{PATH_PROJECT}}|$PROJECT_ROOT|g" \
          runtime/etc/kibana5.yml \
      > runtime/kibana5/kibana.yml
    }

    sudo -u nolimits \
        BABEL_CACHE_PATH="$PROJECT_ROOT/runtime/kibana5/.babelcache.json" \
        DATA_PATH="$PROJECT_ROOT/runtime/kibana5/" \
        kibana -c "$PROJECT_ROOT/runtime/kibana5/kibana.yml" &

    trap finish EXIT

    export PS1="[${name}:\w]$ "
  '';

  kibana5 = pkgs.callPackage /data/projects/private/configuration.nix/packages/kibana5 { nodejs = nodejs-6_x; };

  buildInputs = [
    kibana5
  ];
}
