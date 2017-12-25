with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "project-shell-instream";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    PROJECT_ROOT="/data/projects/private/configuration.nix/runtime/instream"
      
    API_INFLUXDB='http://localhost:8086'
    CONF_INFLUXDB="$PROJECT_ROOT/influxdb.conf"
    LOG_INFLUXDB="$PROJECT_ROOT/influxdb.log"
    PID_INFLUXDB="$PROJECT_ROOT/influxdb.pid"

    function finish {
      [ -f "$PID_INFLUXDB" ] && {
        kill -TERM "$(cat "$PID_INFLUXDB")"
        rm -f "$PID_INFLUXDB"
      }
    }

    function configure_influxdb {
      curl "$API_INFLUXDB/query" \
          -X POST \
          --data-urlencode "q=CREATE USER instream_test WITH PASSWORD 'instream_test' WITH ALL PRIVILEGES" \
          -s -o /dev/null

      curl "$API_INFLUXDB/query" \
          -X POST \
          -u instream_test:instream_test \
          --data-urlencode "q=CREATE USER instream_guest WITH PASSWORD 'instream_guest'" \
          -s -o /dev/null

      sed -i 's/auth-enabled = false/auth-enabled = true/' "$CONF_INFLUXDB"
    }

    function restart_influxdb {
      [ -f "$PID_INFLUXDB" ] && {
        kill -TERM "$(cat "$PID_INFLUXDB")"
        rm -f "$PID_INFLUXDB"
      }

      influxd \
          -config "$CONF_INFLUXDB" \
        -pidfile "$PID_INFLUXDB" \
      2>$LOG_INFLUXDB &

      until curl -s -o /dev/null "$API_INFLUXDB"; do
        sleep 1
      done
    }

    function setup_influxdb {
      mkdir -p "$PROJECT_ROOT"
      chmod 774 "$PROJECT_ROOT"

      influxd config > "$CONF_INFLUXDB"

      sed -i "s|/var/lib/influxdb|$PROJECT_ROOT|g" "$CONF_INFLUXDB"
      echo -e "[[udp]]\n  enabled = true\n  bind-address = \":8089\"\n  database = \"test_database\"\n  batch-size = 1000\n  batch-timeout = \"1s\"\n  batch-pending = 5\n" >> "$CONF_INFLUXDB"
    }

    setup_influxdb
    restart_influxdb

    configure_influxdb
    restart_influxdb

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
