with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "generic-shell-go";

  shellHook = ''
    export GOPATH="$(pwd):$GOPATH"
    export PS1="[generic:go|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = [
    go

    glide
    go2nix
  ];
}
