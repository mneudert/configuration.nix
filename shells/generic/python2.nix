with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "generic-shell-python2";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    export SHELL_DATA_DIR="/data/nix-shells/${name}"

    export PATH="$SHELL_DATA_DIR/bin:$PATH"
    export PS1="[generic:python2|\[\e[1m\]\w\[\e[0m\]]$ "
    export PYTHONUSERBASE="$SHELL_DATA_DIR"
    export PYTHONPATH="$(python -m site --user-site):$PYTHONPATH"
  '';

  buildInputs = [
    python2
    python2Packages.nose
    python2Packages.pep8
    python2Packages.pip
    python2Packages.setuptools
  ];
}
