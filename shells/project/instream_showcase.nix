with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "project-shell-instream_showcase";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    PROJECT_ROOT="/data/projects/private/configuration.nix/runtime/instream_showcase"
    SHELL_LOCK="$PROJECT_ROOT/shell.lock"
    SHELL_NAME="project:instream_showcase"
      
    API_INFLUXDB='http://localhost:8086'
    CONF_INFLUXDB="$PROJECT_ROOT/influxdb.conf"
    LOG_INFLUXDB="$PROJECT_ROOT/influxdb.log"
    PID_INFLUXDB="$PROJECT_ROOT/influxdb.pid"

    function finish {
      [ -f "$PID_INFLUXDB" ] && {
        kill -TERM "$(cat "$PID_INFLUXDB")"
        rm -f "$PID_INFLUXDB"
      }

      rm -f "$SHELL_LOCK"
    }

    function configure_influxdb {
      curl "$API_INFLUXDB/query" \
          -X POST \
          --data-urlencode "q=CREATE USER instream_showcase WITH PASSWORD 'instream_showcase' WITH ALL PRIVILEGES" \
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
      >/dev/null 2>$LOG_INFLUXDB &

      until curl -s -o /dev/null "$API_INFLUXDB"; do
        sleep 1
      done
    }

    function setup_influxdb {
      mkdir -p "$PROJECT_ROOT"

      influxd config > "$CONF_INFLUXDB"

      sed -i "s|/var/lib/influxdb|$PROJECT_ROOT|g" "$CONF_INFLUXDB"
      echo -e "[[udp]]\n  enabled = true\n  bind-address = \":8089\"\n  database = \"test_database\"\n  batch-size = 1000\n  batch-timeout = \"1s\"\n  batch-pending = 5\n" >> "$CONF_INFLUXDB"
    }

    if [ ! -f "$SHELL_LOCK" ]; then
      mkdir -p "$(dirname "$SHELL_LOCK")"
      touch "$SHELL_LOCK"

      SHELL_NAME="$SHELL_NAME|\[\e[1m\]master\[\e[0m\]"

      setup_influxdb
      restart_influxdb

      configure_influxdb
      restart_influxdb

      trap finish EXIT
    fi

    export ERL_AFLAGS="-kernel shell_history enabled"
    export PS1="[$SHELL_NAME|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  influxdb = pkgs.callPackage /data/projects/private/configuration.nix/packages/influxdb {};

  rebar  = pkgs.rebar.override { erlang = erlangR20; };
  elixir = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir-1.5 {
    erlang = erlangR20;
    rebar  = rebar;
  };

  buildInputs = [
    elixir
    erlangR20
    influxdb
    nodejs

    inotify-tools
  ];
}
