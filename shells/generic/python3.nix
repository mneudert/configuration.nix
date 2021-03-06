with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "generic-shell-python3";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    export SHELL_DATA_DIR="$HOME/.nix-shells-data/${name}"

    export PATH="$SHELL_DATA_DIR/bin:$PATH"
    export PS1="[generic:python3|\[\e[1m\]\w\[\e[0m\]]$ "
    export PYTHONPATH="$SHELL_DATA_DIR/lib/python3.7/site-packages:$PYTHONPATH"
    export PYTHONUSERBASE="$SHELL_DATA_DIR"
  '';

  buildInputs = [
    python3
    python3Packages.nose
    python3Packages.pep8
    python3Packages.pip
    python3Packages.setuptools
  ];
}
