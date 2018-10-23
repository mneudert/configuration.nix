with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "template-shell-postgresql";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    PROJECT_ROOT="$(pwd)"
    SHELL_LOCK="$PROJECT_ROOT/runtime/postgresql/shell.lock"
    SHELL_NAME="template:postgresql"

    function finish {
      pg_ctl \
          --pgdata="$PROJECT_ROOT/runtime/postgresql/data" \
          stop

      rm -f "$SHELL_LOCK"
    }

    function setup_postgres {
      mkdir -p runtime/postgresql/data

      initdb \
          --pgdata="$PROJECT_ROOT/runtime/postgresql/data" \
          --pwfile="$PROJECT_ROOT/runtime/etc/postgresql.pwd" \
          --username="postgres" \
      >/dev/null
    }

    if [ ! -f "$SHELL_LOCK" ]; then
      mkdir -p "$(dirname "$SHELL_LOCK")"
      touch "$SHELL_LOCK"

      SHELL_NAME="$SHELL_NAME|\[\e[1m\]master\[\e[0m\]"

      setup_postgres

      pg_ctl \
          --pgdata="$PROJECT_ROOT/runtime/postgresql/data" \
          --log="$PROJECT_ROOT/runtime/postgresql/postgresql.log" \
          -o "-p 5432" \
          start

      trap finish EXIT
    fi

    export PS1="[$SHELL_NAME|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = [
    postgresql
  ];
}
