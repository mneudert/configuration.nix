with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "template-shell-nginx";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    PROJECT_ROOT="$(pwd)"
    PID_NGINX="$PROJECT_ROOT/runtime/nginx/logs/nginx.pid"
    SHELL_LOCK="$PROJECT_ROOT/runtime/nginx/shell.lock"
    SHELL_NAME="${name}"

    function finish {
      [ -f "$PID_NGINX" ] && {
        sudo -u nolimits kill -QUIT "$(cat "$PID_NGINX")"
        sudo -u nolimits rm -f "$PID_NGINX"
      }

      rm -f "$SHELL_LOCK"
    }

    function setup_nginx {
      mkdir -p runtime/nginx/logs

      chmod 774 runtime/nginx
      chmod 774 runtime/nginx/logs

      sed "s|{{PATH_PROJECT}}|$PROJECT_ROOT|g" \
          runtime/etc/nginx.conf \
      > runtime/nginx/nginx.conf
    }

    if [ ! -f "$SHELL_LOCK" ]; then
      mkdir -p "$(dirname "$SHELL_LOCK")"
      touch "$SHELL_LOCK"

      SHELL_NAME="$SHELL_NAME|\[\e[1m\]master\[\e[0m\]"

      setup_nginx

      sudo -u nolimits \
          nginx -c "$PROJECT_ROOT/runtime/nginx/nginx.conf" \
                -p "$PROJECT_ROOT/runtime/nginx"

      trap finish EXIT
    fi

    export PS1="[$SHELL_NAME:\w]$ "
  '';

  buildInputs = [
    nginx
  ];
}
