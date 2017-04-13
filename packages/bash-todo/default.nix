{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name    = "bash-todo";
  version = "934f423";

  src = fetchFromGitHub {
    owner  = "mneudert";
    repo   = "${name}";
    rev    = "934f42329ccc59a3867172f9f324ae7cefa1ab4f";
    sha256 = "0ii6c8v9qwpz20d8yiyj6s36y2qdh6b0n5m8s7dxh78r8l0nvjhb";
  };

  patchPhase   = "patchShebangs ./todo";
  buildPhase   = "mkdir -p $out/bin";
  installPhase = "cp ./todo $out/bin/";
}
