with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "generic-shell-dmd";

  shellHook = ''
    export PS1="[generic:dmd|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = [
    dmd
    dub
  ];
}
