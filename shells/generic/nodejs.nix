with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-nodejs";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[${name}:\w]$ "
  '';

  buildInputs = [
    nodejs
  ];
}
