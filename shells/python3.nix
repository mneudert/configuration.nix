with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "nix-shell-python3";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[${name}:\w]$ "
  '';

  buildInputs = [
    python3
  ];
}
