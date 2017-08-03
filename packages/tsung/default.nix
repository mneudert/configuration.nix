{ stdenv, fetchurl, pkgs }:

stdenv.mkDerivation rec {
  name    = "tsung-${version}";
  version = "1.6.0";

  src = fetchurl {
    url    = "http://tsung.erlang-projects.org/dist/tsung-${version}.tar.gz";
    sha256 = "111xxchbdc5x3vpycbqy952868sj627wnc33lzckfw7xj0x6r12n";
  };

  buildInputs = with pkgs; [
    erlang
  ];
}
