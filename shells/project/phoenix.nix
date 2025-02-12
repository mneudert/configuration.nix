with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "project-shell-phoenix";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    SHELL_NAME="project:phoenix"

    export SHELL_DATA_DIR="/data/nix-shells/${name}"

    export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_path '\"$SHELL_DATA_DIR/erlang-history\"'"
    export HEX_HOME="$SHELL_DATA_DIR/hex"
    export MIX_HOME="$SHELL_DATA_DIR/mix"
    export PS1="[$SHELL_NAME|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  elixir = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir-1.18 { };

  buildInputs = [
    glibcLocales
    elixir
    erlang
    nodejs

    inotify-tools
  ];
}
