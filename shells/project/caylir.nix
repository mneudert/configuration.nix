with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "project-shell-caylir";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    PROJECT_ROOT="/data/projects/private/configuration.nix/runtime/caylir"
    SHELL_LOCK="$PROJECT_ROOT/shell.lock"
    SHELL_NAME="${name}"

    function finish {
      ps | grep 'cayley' | grep -v 'grep' | awk '{ print $1 }' | xargs kill

      rm -f "$SHELL_LOCK"
    }

    if [ ! -f "$SHELL_LOCK" ]; then
      mkdir -p "$(dirname "$SHELL_LOCK")"
      touch "$SHELL_LOCK"

      SHELL_NAME="$SHELL_NAME|\[\e[1m\]master\[\e[0m\]"

      cayley http \
        --db=memstore --dbpath="" \
      2>/dev/null &

      trap finish EXIT
    fi

    export ERL_AFLAGS="-kernel shell_history enabled"
    export PS1="[$SHELL_NAME:\w]$ "
  '';

  rebar = pkgs.rebar.override { erlang = erlangR20; };

  cayley = pkgs.callPackage /data/projects/private/configuration.nix/packages/cayley {};
  elixir = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir {
    erlang = erlangR20;
    rebar  = rebar;
  };

  buildInputs = [
    cayley
    elixir
  ];
}
