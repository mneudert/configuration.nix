with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-elixir-next";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export SHELL_DATA_DIR="$HOME/.nix-shells-data/${name}"

    export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_path '\"$SHELL_DATA_DIR/erlang-history\"'"
    export HEX_HOME="$SHELL_DATA_DIR/hex"
    export MIX_HOME="$SHELL_DATA_DIR/mix"
    export PS1="[generic:elixir-next|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  elixir = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir-next { erlang = erlangR20; };

  buildInputs = [
    elixir
    erlangR20
  ];
}
