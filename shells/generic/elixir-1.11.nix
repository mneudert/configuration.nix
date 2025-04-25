with import <nixos-24.11> { };

let
  pkgs = import <nixos-24.11> {
    config = {
      permittedInsecurePackages = [ "erlang-24.3.4.17" ];
    };
  };
in
stdenv.mkDerivation rec {
  name = "generic-shell-elixir-1.11";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    export SHELL_DATA_DIR="/data/nix-shells/${name}"

    export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_path '\"$SHELL_DATA_DIR/erlang-history\"'"
    export HEX_HOME="$SHELL_DATA_DIR/hex"
    export MIX_HOME="$SHELL_DATA_DIR/mix"
    export PS1="[generic:elixir-1.11|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  elixir = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir-1.11 {
    erlang = pkgs.erlang_24;
  };

  buildInputs = with pkgs; [
    glibcLocales
    elixir
    erlang_24
  ];
}
