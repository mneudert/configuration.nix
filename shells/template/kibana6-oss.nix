with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "template-shell-kibana6-oss";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    PROJECT_ROOT="$(pwd)"
    PID_KIBANA="$PROJECT_ROOT/runtime/kibana6-oss/kibana.pid"
    SHELL_LOCK="$PROJECT_ROOT/runtime/kibana6-oss/shell.lock"
    SHELL_NAME="${name}"

    function finish {
      [ -f "$PID_KIBANA" ] && {
        kill -QUIT "$(cat "$PID_KIBANA")"
        rm -f "$PID_KIBANA"
      }

      rm -f "$SHELL_LOCK"
    }

    function setup_kibana {
      mkdir -p runtime/kibana6-oss

      sed "s|{{PATH_PROJECT}}|$PROJECT_ROOT|g" \
          runtime/etc/kibana6-oss.yml \
      > runtime/kibana6-oss/kibana.yml
    }

    if [ ! -f "$SHELL_LOCK" ]; then
      mkdir -p "$(dirname "$SHELL_LOCK")"
      touch "$SHELL_LOCK"

      SHELL_NAME="$SHELL_NAME|\[\e[1m\]master\[\e[0m\]"

      setup_kibana

      BABEL_CACHE_PATH="$PROJECT_ROOT/runtime/kibana6-oss/.babelcache.json" \
          DATA_PATH="$PROJECT_ROOT/runtime/kibana6-oss/" \
          kibana -c "$PROJECT_ROOT/runtime/kibana6-oss/kibana.yml" &

      trap finish EXIT
    fi

    export PS1="[$SHELL_NAME:\w]$ "
  '';

  kibana6 = pkgs.callPackage /data/projects/private/configuration.nix/packages/kibana6-oss { nodejs = nodejs-8_x; };

  buildInputs = [
    kibana6
  ];
}
