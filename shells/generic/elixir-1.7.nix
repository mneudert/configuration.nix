with import <nixos-21.11> { };

let
  pkgs = import <nixos-21.11> {
    config = {
      permittedInsecurePackages = [ "erlang-22.3.4.24" ];
    };
  };

  erlang = pkgs.beam.interpreters.erlangR22;
  elixir = pkgs.beam.packages.erlangR22.elixir_1_7;
in
stdenv.mkDerivation rec {
  name = "generic-shell-elixir-1.7";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    export SHELL_DATA_DIR="/data/nix-shells/${name}"

    export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_path '\"$SHELL_DATA_DIR/erlang-history\"'"
    export HEX_HOME="$SHELL_DATA_DIR/hex"
    export MIX_HOME="$SHELL_DATA_DIR/mix"
    export PS1="[generic:elixir-1.7|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = with pkgs; [
    glibcLocales
    elixir
    erlang
  ];
}
