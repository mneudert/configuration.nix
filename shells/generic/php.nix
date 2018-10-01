with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-php";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[${name}:\w]$ "
  '';

  buildInputs = [
    php
    phpPackages.composer
  ];
}
