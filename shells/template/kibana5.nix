with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "template-shell-kibana5";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    function finish {
      sudo sh -c " \
          ps a \
          | grep 'kibana' \
          | grep -v 'grep' \
          | awk '{print \$1}' \
          | xargs kill \
      "
    }

    [ ! -d './runtime/elasticsearch' ] && {
      mkdir -p runtime/kibana

      chmod 774 runtime/kibana
    }

    sudo -u nolimits \
        BABEL_CACHE_PATH="$(pwd)/runtime/kibana/.babelcache.json" \
        DATA_PATH="$(pwd)/runtime/kibana/" \
        kibana &

    trap finish EXIT

    export PS1="[${name}:\w]$ "
  '';

  kibana5 = pkgs.callPackage /data/projects/private/configuration.nix/packages/kibana5 { nodejs = nodejs-6_x; };

  buildInputs = with pkgs; [
    kibana5
  ];
}
