with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "generic-shell-dmd";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[generic:dmd|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = [
    dmd
    dub
  ];
}
