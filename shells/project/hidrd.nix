with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "project-shell-hidrd";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    export SHELL_DATA_DIR="/data/nix-shells/${name}"

    if ! grep -q 'usbmon' <( lsmod ); then
      echo 'Configuring usbmon...'

      sudo modprobe usbmon && sudo setfacl -m u:$USER:r /dev/usbmon*
    fi

    export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_path '\"$SHELL_DATA_DIR/erlang-history\"'"
    export HEX_HOME="$SHELL_DATA_DIR/hex"
    export MIX_HOME="$SHELL_DATA_DIR/mix"
    export PS1="[project:hidrd|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  elixir = pkgs.callPackage
    /data/projects/private/configuration.nix/packages/elixir-1.18 { };
  hidrd-convert = pkgs.callPackage
    /data/projects/private/configuration.nix/packages/hidrd-convert { };

  buildInputs = [
    glibcLocales
    elixir
    erlang

    hidrd-convert
    usbutils
  ];
}
