with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "template-shell-kibana-preview";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    PROJECT_ROOT="$(pwd)"
    PID_KIBANA="$PROJECT_ROOT/runtime/kibana-preview/kibana.pid"
    SHELL_LOCK="$PROJECT_ROOT/runtime/kibana-preview/shell.lock"
    SHELL_NAME="template:kibana-preview"

    function finish {
      [ -f "$PID_KIBANA" ] && {
        kill -QUIT "$(cat "$PID_KIBANA")"
        rm -f "$PID_KIBANA"
      }

      rm -f "$SHELL_LOCK"
    }

    function setup_kibana {
      mkdir -p runtime/kibana-preview

      sed "s|{{PATH_PROJECT}}|$PROJECT_ROOT|g" \
          runtime/etc/kibana-preview.yml \
      > runtime/kibana-preview/kibana.yml
    }

    if [ ! -f "$SHELL_LOCK" ]; then
      mkdir -p "$(dirname "$SHELL_LOCK")"
      touch "$SHELL_LOCK"

      SHELL_NAME="$SHELL_NAME|\[\e[1m\]master\[\e[0m\]"

      setup_kibana

      BABEL_CACHE_PATH="$PROJECT_ROOT/runtime/kibana-preview/.babelcache.json" \
          kibana -c "$PROJECT_ROOT/runtime/kibana-preview/kibana.yml" &

      trap finish EXIT
    fi

    export PS1="[$SHELL_NAME|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  kibana = pkgs.callPackage
    /data/projects/private/configuration.nix/packages/kibana-preview { };

  buildInputs = [ kibana ];
}
