with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "template-shell-nginx";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    function finish {
      sudo sh -c " \
          ps a \
          | grep 'nginx' \
          | grep -v 'grep' \
          | awk '{print \$1}' \
          | xargs kill \
      "
    }

    [ ! -d './runtime/nginx' ] && {
      mkdir -p runtime/nginx/logs

      chmod 774 runtime/nginx
      chmod 774 runtime/nginx/logs

      sed "s|{{PATH_PROJECT}}|$(pwd)|g" \
          runtime/etc/nginx.conf \
      > runtime/nginx/nginx.conf
    }

    sudo -u nolimits \
        nginx -c "$(pwd)/runtime/nginx/nginx.conf" \
              -p "$(pwd)/runtime/nginx"

    trap finish EXIT

    export PS1="[${name}:\w]$ "
  '';

  buildInputs = with pkgs; [
    nginx
  ];
}
