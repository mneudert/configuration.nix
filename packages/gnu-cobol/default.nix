{ stdenv, fetchurl, pkgs }:

stdenv.mkDerivation rec {
  name    = "gnu-cobol-${version}";
  version = "3.0-rc1";

  src = fetchurl {
    url    = "mirror://sourceforge/open-cobol/gnu-cobol/3.0/gnucobol-${version}.tar.gz";
    sha256 = "05j85szps8yh7x37dk2d3dksfvdhiv3j1dfl9hxpczppn6kfwnp5";
  };

  propagatedBuildInputs = with pkgs; [
    db
    gmp
    ncurses
  ];
}
