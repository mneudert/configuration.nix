with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-dmd";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[${name}:\w]$ "
  '';

  buildInputs = [
    dmd
    dub
  ];
}
