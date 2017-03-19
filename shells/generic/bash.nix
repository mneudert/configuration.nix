with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-bash";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[${name}:\w]$ "
  '';

  buildInputs = [
    bats
    shellcheck
  ];
}
