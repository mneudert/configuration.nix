with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "template-shell-nginx";

  shellHook = ''
    PROJECT_ROOT="$(pwd)"
    PID_NGINX="$PROJECT_ROOT/runtime/nginx/logs/nginx.pid"
    SHELL_LOCK="$PROJECT_ROOT/runtime/nginx/shell.lock"
    SHELL_NAME="template:nginx"

    function finish {
      [ -f "$PID_NGINX" ] && {
        kill -QUIT "$(cat "$PID_NGINX")"
        rm -f "$PID_NGINX"
      }

      rm -f "$SHELL_LOCK"
    }

    function setup_nginx {
      mkdir -p "$PROJECT_ROOT/runtime/nginx/logs"

      sed "s|{{PATH_PROJECT}}|$PROJECT_ROOT|g" \
          "$PROJECT_ROOT/runtime/etc/nginx.conf" \
      > "$PROJECT_ROOT/runtime/nginx/nginx.conf"
    }

    if [ ! -f "$SHELL_LOCK" ]; then
      mkdir -p "$(dirname "$SHELL_LOCK")"
      touch "$SHELL_LOCK"

      SHELL_NAME="$SHELL_NAME|\[\e[1m\]master\[\e[0m\]"

      setup_nginx

      nginx -c "$PROJECT_ROOT/runtime/nginx/nginx.conf" \
            -p "$PROJECT_ROOT/runtime/nginx"

      trap finish EXIT
    fi

    export PS1="[$SHELL_NAME|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = [ nginx ];
}
