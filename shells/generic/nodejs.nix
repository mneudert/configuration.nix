with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "generic-shell-nodejs";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[generic:nodejs|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = [ nodejs ];
}
