with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "template-shell-elasticsearch6";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    PROJECT_ROOT="$(pwd)"
    PID_ELASTICSEARCH="$PROJECT_ROOT/runtime/elasticsearch/elasticsearch.pid"

    function finish {
      [ -f "$PID_ELASTICSEARCH" ] && {
        sudo -u nolimits kill -QUIT "$(cat "$PID_ELASTICSEARCH")"
        sudo -u nolimits rm -f "$PID_ELASTICSEARCH"
      }
    }

    [ ! -d './runtime/elasticsearch' ] && {
      mkdir -p runtime/elasticsearch

      chmod 774 runtime/elasticsearch

      pushd runtime/elasticsearch
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

        pushd config
          ln -fs ../../etc/elasticsearch.yml
          ln -fs "$elastic_base/config/jvm.options"
          ln -fs "$elastic_base/config/log4j2.properties"
        popd
      popd
    }

    sudo sysctl -w vm.max_map_count=262144
    sudo -u nolimits \
        ES_HOME="$PROJECT_ROOT/runtime/elasticsearch" \
        elasticsearch -p "$PID_ELASTICSEARCH" &

    trap finish EXIT

    export PS1="[${name}:\w]$ "
  '';

  elasticsearch6 = pkgs.callPackage /data/projects/private/configuration.nix/packages/elasticsearch6 {};

  buildInputs = [
    elasticsearch6
  ];
}
