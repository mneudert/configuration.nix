with import <nixos-25.11> { };

let
  erlang = pkgs.beam.interpreters.erlang_28;
  elixir = pkgs.beam.packages.erlang_28.elixir_1_18;
in
stdenv.mkDerivation rec {
  name = "generic-shell-elixir-1.18";

  shellHook = ''
    export SHELL_DATA_DIR="/data/nix-shells/${name}"

    export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_path '\"$SHELL_DATA_DIR/erlang-history\"'"
    export HEX_HOME="$SHELL_DATA_DIR/hex"
    export MIX_HOME="$SHELL_DATA_DIR/mix"
    export PS1="[generic:elixir-1.18|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = [
    glibcLocales
    elixir
    erlang
  ];
}
