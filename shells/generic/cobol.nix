with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "generic-shell-cobol";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[generic:cobol|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = [ gnu-cobol ];
}
