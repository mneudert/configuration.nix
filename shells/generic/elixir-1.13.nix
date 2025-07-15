with import <nixos-24.11> { };

let
  erlang = pkgs.beam.interpreters.erlang_25;
  elixir = pkgs.beam.packages.erlang_25.elixir_1_13;
in
stdenv.mkDerivation rec {
  name = "generic-shell-elixir-1.13";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    export SHELL_DATA_DIR="/data/nix-shells/${name}"

    export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_path '\"$SHELL_DATA_DIR/erlang-history\"'"
    export HEX_HOME="$SHELL_DATA_DIR/hex"
    export MIX_HOME="$SHELL_DATA_DIR/mix"
    export PS1="[generic:elixir-1.13|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = [
    glibcLocales
    elixir
    erlang
  ];
}
