with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-bash";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[generic:bash|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = [
    bats
    shellcheck
  ];
}
