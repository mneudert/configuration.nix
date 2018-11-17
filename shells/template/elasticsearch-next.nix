with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "template-shell-elasticsearch-next";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    PROJECT_ROOT="$(pwd)"
    PID_ELASTICSEARCH="$PROJECT_ROOT/runtime/elasticsearch-next/elasticsearch.pid"
    SHELL_LOCK="$PROJECT_ROOT/runtime/elasticsearch-next/shell.lock"
    SHELL_NAME="template:elasticsearch-next"

    function finish {
      [ -f "$PID_ELASTICSEARCH" ] && {
        sudo -u nolimits kill -TERM "$(cat "$PID_ELASTICSEARCH")"
        sudo -u nolimits rm -f "$PID_ELASTICSEARCH"
      }

      rm -f "$SHELL_LOCK"
    }

    function setup_elasticsearch {
      mkdir -p runtime/elasticsearch-next
      chmod 774 runtime/elasticsearch-next

      pushd runtime/elasticsearch-next > /dev/null
        elastic_base=$(dirname $(dirname $(which elasticsearch)))

        ln -fs "$elastic_base/bin/"
        ln -fs "$elastic_base/lib/"
        ln -fs "$elastic_base/modules/"

        mkdir -p config/scripts
        mkdir -p data
        mkdir -p logs
        mkdir -p plugins

        chmod 774 config
        chmod 774 data
        chmod 774 logs

        pushd config > /dev/null
          ln -fs ../../etc/elasticsearch-next.yml elasticsearch.yml
          ln -fs "$elastic_base/config/jvm.options"
          ln -fs "$elastic_base/config/log4j2.properties"
        popd > /dev/null
      popd > /dev/null
    }

    if [ ! -f "$SHELL_LOCK" ]; then
      mkdir -p "$(dirname "$SHELL_LOCK")"
      touch "$SHELL_LOCK"

      SHELL_NAME="$SHELL_NAME|\[\e[1m\]master\[\e[0m\]"

      setup_elasticsearch

      sudo sysctl -w vm.max_map_count=262144 > /dev/null
      sudo -u nolimits \
          ES_HOME="$PROJECT_ROOT/runtime/elasticsearch-next/bin" \
          elasticsearch -d -p "$PID_ELASTICSEARCH"

      trap finish EXIT
    fi

    export PS1="[$SHELL_NAME|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  elasticsearch-next = pkgs.callPackage /data/projects/private/configuration.nix/packages/elasticsearch-next {};

  buildInputs = [
    elasticsearch-next
  ];
}
