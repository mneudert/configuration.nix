with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "project-shell-hidrd";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    if ! grep -q 'usbmon' <( lsmod ); then
      echo 'Configuring usbmon...'

      sudo modprobe usbmon && sudo setfacl -m u:$USER:r /dev/usbmon*
    fi

    export ERL_AFLAGS="-kernel shell_history enabled"
    export PS1="[project:hidrd|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  elixir = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir-1.8 {};
  hidrd-convert = pkgs.callPackage /data/projects/private/configuration.nix/packages/hidrd-convert {};

  buildInputs = [
    elixir
    erlang

    hidrd-convert
    usbutils
  ];
}
