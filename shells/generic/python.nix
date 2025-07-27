with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "generic-shell-python";

  shellHook = ''
    export SHELL_DATA_DIR="/data/nix-shells/${name}"

    virtualenv "$SHELL_DATA_DIR/venv"
    source "$SHELL_DATA_DIR/venv/bin/activate"

    export PATH="$SHELL_DATA_DIR/bin:$PATH"
    export PS1="[generic:python|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = [
    poetry
    python3
    python3Packages.pip
    python3Packages.pipx
    python3Packages.pycodestyle
    python3Packages.pytest
    python3Packages.setuptools
    python3Packages.virtualenv
  ];
}
