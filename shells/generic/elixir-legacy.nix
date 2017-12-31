with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-elixir-legacy";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[${name}:\w]$ "
  '';

  buildInputs = [
    beam.packages.erlangR18.elixir_1_3
    erlangR18
  ];
}
