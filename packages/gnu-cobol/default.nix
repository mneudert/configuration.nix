{ stdenv, fetchsvn, pkgs }:

stdenv.mkDerivation rec {
  name    = "gnu-cobol";
  version = "1576";

  src = fetchsvn {
    url    = "svn://svn.code.sf.net/p/open-cobol/code/branches/gnu-cobol-2.0";
    rev    = version;
    sha256 = "19bnqrpzxdgh5hvwf38fg3nb69pc4lqz6f9jlz0m7kp6mnv1lah7";
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
