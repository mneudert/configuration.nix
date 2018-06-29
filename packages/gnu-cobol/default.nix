{ stdenv, fetchurl, pkgs }:

stdenv.mkDerivation rec {
  name    = "gnu-cobol-${version}";
  version = "2.2";

  src = fetchurl {
    url    = "mirror://sourceforge/open-cobol/gnu-cobol/${version}/gnucobol-${version}.tar.gz";
    sha256 = "1jrjmdx0swssjh388pp08awhiisbrs2i7gx4lcm4p1k5rpg3hn4j";
  };

  propagatedBuildInputs = with pkgs; [
    db
    gmp
    ncurses
  ];
}
