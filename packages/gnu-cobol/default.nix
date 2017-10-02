{ stdenv, fetchsvn, pkgs }:

stdenv.mkDerivation rec {
  name    = "gnu-cobol-${version}";
  version = "2017-08-02";

  src = fetchsvn {
    url    = "svn://svn.code.sf.net/p/open-cobol/code/branches/gnucobol-2.x";
    rev    = "1903";
    sha256 = "02nljdmjch439g8avqp8hyl1l66nj106a5jw35viwi3cal56vnzj";
  };

  patchPhase =
    ''
      sed -i -e 's|/usr/bin/file|${pkgs.file}/bin/file|g' configure
    '';

  propagatedBuildInputs = with pkgs; [
    db
    gmp
    ncurses
  ];

  buildInputs = with pkgs; [
    file
    flex
    help2man
    texinfo
    yacc
  ];
}
