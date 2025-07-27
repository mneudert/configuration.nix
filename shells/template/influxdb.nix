with import <nixos-22.05> { };

stdenv.mkDerivation rec {
  name = "template-shell-influxdb";

  shellHook = ''
    PROJECT_ROOT="$(pwd)"
    SHELL_LOCK="$PROJECT_ROOT/runtime/influxdb/shell.lock"
    SHELL_NAME="template:influxdb"

    API_INFLUXDB='http://localhost:8086'
    CONF_INFLUXDB="$PROJECT_ROOT/runtime/influxdb/influxdb.conf"
    LOG_INFLUXDB="$PROJECT_ROOT/runtime/influxdb/influxdb.log"
    PID_INFLUXDB="$PROJECT_ROOT/runtime/influxdb/influxdb.pid"

    function finish {
      [ -f "$PID_INFLUXDB" ] && {
        kill -TERM "$(cat "$PID_INFLUXDB")"
        rm -f "$PID_INFLUXDB"
      }

      rm -f "$SHELL_LOCK"
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
      influxd config > "$CONF_INFLUXDB"

      sed -i "s|/var/lib/influxdb|$PROJECT_ROOT|g" "$CONF_INFLUXDB"

      sed -i "s|reporting-disabled = false|reporting-disabled = true|" "$CONF_INFLUXDB"
    }

    if [ ! -f "$SHELL_LOCK" ]; then
      mkdir -p "$(dirname "$SHELL_LOCK")"
      touch "$SHELL_LOCK"

      SHELL_NAME="$SHELL_NAME|\[\e[1m\]master\[\e[0m\]"

      setup_influxdb
      restart_influxdb

      trap finish EXIT
    fi

    export ERL_AFLAGS="-kernel shell_history enabled"
    export PS1="[$SHELL_NAME|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = [ influxdb ];
}
