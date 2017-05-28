with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "project-shell-instream";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    PROJECT_ROOT="/data/projects/private/configuration.nix/runtime/instream"
    CONF_INFLUXDB="$PROJECT_ROOT/influxdb.conf"
    LOG_INFLUXDB="$PROJECT_ROOT/influxdb.log"
    PID_INFLUXDB="$PROJECT_ROOT/influxdb.pid"

    function finish {
      [ -f "$PID_INFLUXDB" ] && {
        kill -TERM "$(cat "$PID_INFLUXDB")"
        rm -f "$PID_INFLUXDB"
      }
    }

    function setup_influxdb {
      local api_base='http://localhost:8086'

      until curl -s -o /dev/null "$api_base"; do
        sleep 1
      done

      curl "$api_base/query" \
          -X POST \
          --data-urlencode "q=CREATE USER instream_test WITH PASSWORD 'instream_test' WITH ALL PRIVILEGES" \
          -s -o /dev/null

      curl "$api_base/query" \
          -X POST \
          -u instream_test:instream_test \
          --data-urlencode "q=CREATE USER instream_guest WITH PASSWORD 'instream_guest'" \
          -s -o /dev/null
    }

    [ ! -d "$PROJECT_ROOT" ] && {
      mkdir -p $PROJECT_ROOT
      chmod 774 $PROJECT_ROOT
    }

    influxd \
        -config "$CONF_INFLUXDB" \
        -pidfile "$PID_INFLUXDB" \
    2>$LOG_INFLUXDB &

    setup_influxdb

    trap finish EXIT

    export PS1="[${name}:\w]$ "
  '';

  elixir   = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir {};
  influxdb = pkgs.callPackage /data/projects/private/configuration.nix/packages/influxdb {};

  buildInputs = [
    elixir
    influxdb
  ];
}
