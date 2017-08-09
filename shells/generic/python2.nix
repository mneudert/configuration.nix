with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-python2";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[${name}:\w]$ "
  '';

  buildInputs = [
    python2
    python2Packages.nose
    python2Packages.pip
  ];
}
