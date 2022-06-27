{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "bash-todo-${version}";
  version = "2022-06-27";

  src = fetchFromGitHub {
    owner = "mneudert";
    repo = "bash-todo";
    rev = "7829492054e12f00b52af04af1ade154c0b4dd70";
    hash = "sha256-7dTAQcXC5nyF0dSjDrRgbVAs34QUGKJJN4UHQonw8uw=";
  };

  patchPhase = "patchShebangs ./todo";
  buildPhase = "mkdir -p $out/bin";
  installPhase = "cp ./todo $out/bin/";
}
