{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name    = "bash-todo-${version}";
  version = "2017-11-26";

  src = fetchFromGitHub {
    owner  = "mneudert";
    repo   = "bash-todo";
    rev    = "12ffb243f17b2b24a74c3ecc6a97df661abaae6e";
    sha256 = "18rbk0h9wqi5h8bm52fjn1hjsvn6ldpqhfpqch3fg87wv525k1zb";
  };

  patchPhase   = "patchShebangs ./todo";
  buildPhase   = "mkdir -p $out/bin";
  installPhase = "cp ./todo $out/bin/";
}
