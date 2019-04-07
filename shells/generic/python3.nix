with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-python3";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[generic:python3|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = [
    python3
    python3Packages.nose
    python3Packages.pep8
    python3Packages.pip
  ];
}
