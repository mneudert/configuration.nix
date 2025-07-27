with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "generic-shell-nodejs";

  shellHook = ''
    export PS1="[generic:nodejs|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = [ nodejs_20 ];
}
