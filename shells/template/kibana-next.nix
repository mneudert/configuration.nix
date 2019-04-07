with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "template-shell-kibana-next";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    PROJECT_ROOT="$(pwd)"
    PID_KIBANA="$PROJECT_ROOT/runtime/kibana-next/kibana.pid"
    SHELL_LOCK="$PROJECT_ROOT/runtime/kibana-next/shell.lock"
    SHELL_NAME="template:kibana-next"

    function finish {
      [ -f "$PID_KIBANA" ] && {
        kill -QUIT "$(cat "$PID_KIBANA")"
        rm -f "$PID_KIBANA"
      }

      rm -f "$SHELL_LOCK"
    }

    function setup_kibana {
      mkdir -p runtime/kibana-next

      sed "s|{{PATH_PROJECT}}|$PROJECT_ROOT|g" \
          runtime/etc/kibana-next.yml \
      > runtime/kibana-next/kibana.yml
    }

    if [ ! -f "$SHELL_LOCK" ]; then
      mkdir -p "$(dirname "$SHELL_LOCK")"
      touch "$SHELL_LOCK"

      SHELL_NAME="$SHELL_NAME|\[\e[1m\]master\[\e[0m\]"

      setup_kibana

      BABEL_CACHE_PATH="$PROJECT_ROOT/runtime/kibana-next/.babelcache.json" \
          DATA_PATH="$PROJECT_ROOT/runtime/kibana-next/" \
          kibana -c "$PROJECT_ROOT/runtime/kibana-next/kibana.yml" &

      trap finish EXIT
    fi

    export PS1="[$SHELL_NAME|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  kibana-next = pkgs.callPackage /data/projects/private/configuration.nix/packages/kibana-next {};

  buildInputs = [
    kibana-next
  ];
}
