{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name    = "bash-todo";
  version = "40e3631";

  src = fetchFromGitHub {
    owner  = "mneudert";
    repo   = "${name}";
    rev    = "40e36312dd3b91ee29c8c2594fb131f8c92723bc";
    sha256 = "01j0bwx7jlwbf509fz6dvi7gkzdvivicqpg2h8pz0761cprmb0vq";
  };

  patchPhase   = "patchShebangs ./todo";
  buildPhase   = "mkdir -p $out/bin";
  installPhase = "cp ./todo $out/bin/";
}
