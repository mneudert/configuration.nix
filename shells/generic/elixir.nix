with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-elixir";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[${name}:\w]$ "
  '';

  elixir = pkgs.callPackage /data/projects/private/configuration.nix/backports/elixir {};

  buildInputs = [
    elixir
  ];
}
