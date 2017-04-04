with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "template-shell-elasticsearch5";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    function finish {
      sudo sh -c " \
          ps a \
          | grep 'org.elasticsearch.bootstrap.Elasticsearch' \
          | grep -v 'grep' \
          | awk '{print \$1}' \
          | xargs kill \
      "
    }

    [ ! -d './runtime/elasticsearch' ] && {
      mkdir -p runtime/elasticsearch

      cd runtime/elasticsearch
        elastic_base=$(dirname $(dirname $(which elasticsearch)))

        ln -fs "$elastic_base/bin/"
        ln -fs "$elastic_base/lib/"
        ln -fs "$elastic_base/modules/"

        mkdir config
        mkdir config/scripts
        mkdir data
        mkdir logs
        mkdir plugins

        chmod 774 data
        chmod 774 logs

        cd config
          ln -fs ../../etc/elasticsearch.yml
          ln -fs "$elastic_base/config/jvm.options"
          ln -fs "$elastic_base/config/log4j2.properties"
        cd ..
      cd ../../
    }

    sudo sysctl -w vm.max_map_count=262144
    sudo -u nolimits \
        ES_HOME="$(pwd)/runtime/elasticsearch" \
        elasticsearch &

    trap finish EXIT

    export PS1="[${name}:\w]$ "
  '';

  elasticsearch5 = pkgs.callPackage /data/projects/private/configuration.nix/packages/elasticsearch5 {};

  buildInputs = with pkgs; [
    elasticsearch5
  ];
}
