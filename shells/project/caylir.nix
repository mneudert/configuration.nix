with import <nixos-24.11> { };

let
  pkgs = import <nixos-24.11> {
    config = {
      permittedInsecurePackages = [ "erlang-24.3.4.17" ];
    };
  };

  erlang = pkgs.beam.interpreters.erlang_24;
  elixir = pkgs.beam.packages.erlang_24.elixir_1_11;
in
stdenv.mkDerivation rec {
  name = "project-shell-caylir";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    PROJECT_ROOT="/data/projects/private/configuration.nix/runtime/caylir"
    SHELL_LOCK="$PROJECT_ROOT/shell.lock"
    SHELL_NAME="project:caylir"

    function finish {
      ps | grep 'cayley' | grep -v 'grep' | awk '{ print $1 }' | xargs kill

      rm -f "$SHELL_LOCK"
    }

    if [ ! -f "$SHELL_LOCK" ]; then
      mkdir -p "$(dirname "$SHELL_LOCK")"
      touch "$SHELL_LOCK"

      SHELL_NAME="$SHELL_NAME|\[\e[1m\]master\[\e[0m\]"

      cayley http 2>/dev/null &

      trap finish EXIT
    fi

    export SHELL_DATA_DIR="/data/nix-shells/${name}"

    export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_path '\"$SHELL_DATA_DIR/erlang-history\"'"
    export HEX_HOME="$SHELL_DATA_DIR/hex"
    export MIX_HOME="$SHELL_DATA_DIR/mix"
    export PS1="[$SHELL_NAME|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  cayley = pkgs.callPackage /data/projects/private/configuration.nix/packages/cayley { };

  buildInputs = with pkgs; [
    glibcLocales
    cayley
    elixir
    erlang
  ];
}
