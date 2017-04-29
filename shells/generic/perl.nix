with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-perl";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[${name}:\w]$ "
  '';

  buildInputs = [
    perl

    nix-generate-from-cpan
  ];
}
