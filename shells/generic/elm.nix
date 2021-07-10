with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "generic-shell-elm";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[generic:elm|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = [ elmPackages.elm ];
}
