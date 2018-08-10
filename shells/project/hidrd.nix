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
    export PS1="[${name}:\w]$ "
  '';

  elixir = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir { erlang = erlangR20; };
  hidrd-convert = pkgs.callPackage /data/projects/private/configuration.nix/packages/hidrd-convert {};

  buildInputs = [
    elixir
    erlangR20

    hidrd-convert
    usbutils
  ];
}
