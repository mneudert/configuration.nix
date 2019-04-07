# requires "openssl" to be already installed!
{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "iecompanion-${version}";
  version = "2017-06-06";

  src = fetchFromGitHub {
    owner = "mneudert";
    repo = "iecompanion";
    rev = "b8fb18e907df3a4bf01f4da27277750401f9554b";
    sha256 = "0yxr8bf08p74kl9g5dxii22rhdbcyan519kns9ndg74iwbv9mdr1";
  };

  patchPhase = "patchShebangs ./iecompanion.sh";
  buildPhase = "mkdir -p $out/bin";
  installPhase = "cp ./iecompanion.sh $out/bin/";
}
