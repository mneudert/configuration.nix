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

    function finish {
      [ -f "$PID_NGINX" ] && {
        sudo -u nolimits kill -QUIT "$(cat "$PID_NGINX")"
        sudo -u nolimits rm -f "$PID_NGINX"
      }
    }

    function setup_nginx {
      mkdir -p runtime/nginx/logs

      chmod 774 runtime/nginx
      chmod 774 runtime/nginx/logs

      sed "s|{{PATH_PROJECT}}|$PROJECT_ROOT|g" \
          runtime/etc/nginx.conf \
      > runtime/nginx/nginx.conf
    }

    setup_nginx

    sudo -u nolimits \
        nginx -c "$PROJECT_ROOT/runtime/nginx/nginx.conf" \
              -p "$PROJECT_ROOT/runtime/nginx"

    trap finish EXIT

    export PS1="[${name}:\w]$ "
  '';

  buildInputs = [
    nginx
  ];
}
