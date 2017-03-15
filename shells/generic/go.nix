with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-go";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[${name}:\w]$ "
  '';

  buildInputs = [
    go

    glide
    go2nix
  ];
}
