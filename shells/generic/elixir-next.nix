with import <nixpkgs> { };

let
  erlang = pkgs.beam.interpreters.erlang_28;
  elixir = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir-1.18 {
    erlang = erlang_28;
  };
in
stdenv.mkDerivation rec {
  name = "generic-shell-elixir-next";

  shellHook = ''
    export SHELL_DATA_DIR="/data/nix-shells/${name}"

    export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_path '\"$SHELL_DATA_DIR/erlang-history\"'"
    export HEX_HOME="$SHELL_DATA_DIR/hex"
    export MIX_HOME="$SHELL_DATA_DIR/mix"
    export PS1="[generic:elixir-next|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = [
    glibcLocales
    elixir
    erlang
  ];
}
