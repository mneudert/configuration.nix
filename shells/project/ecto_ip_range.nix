with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "project-shell-ecto_ip_range";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    PROJECT_ROOT="/data/projects/private/configuration.nix/runtime/ecto_ip_range"
    SHELL_LOCK="$PROJECT_ROOT/shell.lock"
    SHELL_NAME="project:ecto_ip_range"

    function finish {
      pg_ctl \
          --pgdata="$PROJECT_ROOT/pgdata" \
          stop

      rm -f "$SHELL_LOCK"
    }

    function setup_postgres {
      [ -f "$PROJECT_ROOT/pgdata/pg_hba.conf" ] && return

      mkdir -p "$PROJECT_ROOT/pgdata"

      initdb \
          --pgdata="$PROJECT_ROOT/pgdata" \
          --pwfile="/data/projects/private/configuration.nix/runtime/etc/postgresql.pwd" \
          --username="postgres" \
          --auth="md5" \
      >/dev/null

      echo "unix_socket_directories = '$PROJECT_ROOT'" \
          >> "$PROJECT_ROOT/pgdata/postgresql.conf"
    }

    if [ ! -f "$SHELL_LOCK" ]; then
      mkdir -p "$(dirname "$SHELL_LOCK")"
      touch "$SHELL_LOCK"

      SHELL_NAME="$SHELL_NAME|\[\e[1m\]master\[\e[0m\]"

      setup_postgres

      pg_ctl \
          --pgdata="$PROJECT_ROOT/pgdata" \
          --log="$PROJECT_ROOT/postgresql.log" \
          -o "-p 5432" \
          start

      trap finish EXIT
    fi

    export SHELL_DATA_DIR="$HOME/.nix-shells-data/${name}"

    export PGHOST="$PROJECT_ROOT"

    export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_path '\"$SHELL_DATA_DIR/erlang-history\"'"
    export HEX_HOME="$SHELL_DATA_DIR/hex"
    export MIX_HOME="$SHELL_DATA_DIR/mix"
    export PS1="[project:phoenix|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  elixir = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir-1.9 {};
  postgresql_ip4r = pkgs.callPackage /data/projects/private/configuration.nix/packages/postgresql/ip4r {};
  postgresql = pkgs.postgresql.withPackages (_: [ postgresql_ip4r ]);

  buildInputs = [
    elixir
    postgresql
  ];
}
