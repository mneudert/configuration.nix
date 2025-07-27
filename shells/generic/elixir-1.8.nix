with import <nixos-21.11> { };

let
  erlang = pkgs.beam.interpreters.erlangR23;
  elixir = pkgs.beam.packages.erlangR23.elixir_1_8;
in
stdenv.mkDerivation rec {
  name = "generic-shell-elixir-1.8";

  shellHook = ''
    export SHELL_DATA_DIR="/data/nix-shells/${name}"

    export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_path '\"$SHELL_DATA_DIR/erlang-history\"'"
    export HEX_HOME="$SHELL_DATA_DIR/hex"
    export MIX_HOME="$SHELL_DATA_DIR/mix"
    export PS1="[generic:elixir-1.8|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = with pkgs; [
    glibcLocales
    elixir
    erlang
  ];
}
