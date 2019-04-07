{ stdenv, fetchurl, pkgs }:

stdenv.mkDerivation rec {
  name = "tsung-${version}";
  version = "1.7.0";

  src = fetchurl {
    url = "http://tsung.erlang-projects.org/dist/tsung-${version}.tar.gz";
    sha256 = "0ap55kx7y42i069bqi8i60bvq1mj7idajvf4z3nzld7gc1c49533";
  };

  buildInputs = with pkgs; [
    erlang
  ];
}
