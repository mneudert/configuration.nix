{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "bash-todo-${version}";
  version = "2021-02-24";

  src = fetchFromGitHub {
    owner = "mneudert";
    repo = "bash-todo";
    rev = "12fa02d906f6d311b79fa32ec6665de9791087b4";
    hash = "sha256-opeCHM9lGjX4ESZm4nuT1t5tKLt6sUK4KrxTzL23W50=";
  };

  patchPhase = "patchShebangs ./todo";
  buildPhase = "mkdir -p $out/bin";
  installPhase = "cp ./todo $out/bin/";
}
