with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "project-shell-hidrd";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export ERL_AFLAGS="-kernel shell_history enabled"
    export PS1="[${name}:\w]$ "
  '';

  rebar = pkgs.rebar.override { erlang = erlangR20; };

  elixir = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir {
    erlang = erlangR20;
    rebar  = rebar;
  };

  hidrd-convert = pkgs.callPackage /data/projects/private/configuration.nix/packages/hidrd-convert {};

  buildInputs = [
    elixir
    erlangR20

    hidrd-convert
    usbutils
  ];
}
