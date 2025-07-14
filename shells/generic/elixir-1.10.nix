with import <nixos-23.05> { };

let
  pkgs = import <nixos-23.05> {
    config = {
      permittedInsecurePackages = [ "openssl-1.1.1w" ];
    };
  };

  erlang = pkgs.beam.interpreters.erlangR23;
  elixir = pkgs.beam.packages.erlangR23.elixir_1_10;
in
stdenv.mkDerivation rec {
  name = "generic-shell-elixir-1.10";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    export SHELL_DATA_DIR="/data/nix-shells/${name}"

    export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_path '\"$SHELL_DATA_DIR/erlang-history\"'"
    export HEX_HOME="$SHELL_DATA_DIR/hex"
    export MIX_HOME="$SHELL_DATA_DIR/mix"
    export PS1="[generic:elixir-1.10|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = with pkgs; [
    glibcLocales
    elixir
    erlang
  ];
}
