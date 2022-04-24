{ stdenv, fetchurl, pkgs }:

stdenv.mkDerivation rec {
  name = "tsung-${version}";
  version = "1.7.0";

  src = fetchurl {
    url = "http://tsung.erlang-projects.org/dist/tsung-${version}.tar.gz";
    hash = "sha256-Y5REWGDvNPrt+MRtqVo8sga8FzARRbySAVEQf/os5So=";
  };

  buildInputs = with pkgs; [ erlang ];
}
