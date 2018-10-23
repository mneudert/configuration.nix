with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-python2";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[generic:python2|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = [
    python2
    python2Packages.nose
    python2Packages.pep8
    python2Packages.pip
  ];
}
