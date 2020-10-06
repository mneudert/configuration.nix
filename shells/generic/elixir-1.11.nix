with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-elixir-1.11";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    export SHELL_DATA_DIR="$HOME/.nix-shells-data/${name}"

    export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_path '\"$SHELL_DATA_DIR/erlang-history\"'"
    export HEX_HOME="$SHELL_DATA_DIR/hex"
    export MIX_HOME="$SHELL_DATA_DIR/mix"
    export PS1="[generic:elixir-1.11|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  elixir = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir-1.11 {};

  buildInputs = [
    elixir
    erlang
  ];
}
