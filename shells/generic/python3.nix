with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-python3";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[${name}:\w]$ "
  '';

  buildInputs = [
    python3
    python3Packages.pip
  ];
}
