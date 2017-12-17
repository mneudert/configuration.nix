{ stdenv, fetchsvn, pkgs }:

stdenv.mkDerivation rec {
  name    = "gnu-cobol-${version}";
  version = "2.2";

  src = fetchsvn {
    url    = "svn://svn.code.sf.net/p/open-cobol/code/tags/gnucobol-${version}";
    rev    = "2062";
    sha256 = "0zs3way8yrgnbvlxahaaw2f8y91h5vwcjnc4snsihnbkbz0nky5j";
  };

  preConfigure = ''
    ./build_aux/bootstrap
  '';

  propagatedBuildInputs = with pkgs; [
    db
    gmp
    ncurses
  ];

  buildInputs = with pkgs; [
    autoconf
    automake
    file
    flex
    help2man
    texinfo
    yacc
  ];
}
