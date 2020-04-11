with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "template-shell-mysql";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    PROJECT_ROOT="$(pwd)"
    PID_MYSQL="$PROJECT_ROOT/runtime/mysql/mysqld.pid"
    SHELL_LOCK="$PROJECT_ROOT/runtime/mysql/shell.lock"
    SHELL_NAME="template:mysql"

    function finish {
      [ -f "$PID_MYSQL" ] && {
        kill -TERM "$(cat "$PID_MYSQL")"
        rm -f "$PID_MYSQL"
      }

      rm -f "$SHELL_LOCK"
    }

    function setup_mysql {
      mkdir -p runtime/mysql/data

      sed "s|{{PATH_PROJECT}}|$PROJECT_ROOT|g" \
          runtime/etc/mysql.cnf \
      > runtime/mysql/my.cnf

      mysqld --defaults-file="$PROJECT_ROOT/runtime/mysql/my.cnf" --initialize-insecure
    }

    if [ ! -f "$SHELL_LOCK" ]; then
      mkdir -p "$(dirname "$SHELL_LOCK")"
      touch "$SHELL_LOCK"

      SHELL_NAME="$SHELL_NAME|\[\e[1m\]master\[\e[0m\]"

      setup_mysql

      mysqld --defaults-file="$PROJECT_ROOT/runtime/mysql/my.cnf" &

      trap finish EXIT
    fi

    export MYSQL_UNIX_PORT="$PROJECT_ROOT/runtime/mysql/mysqld.sock"
    export PS1="[$SHELL_NAME|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = [
    mysql57
  ];
}
