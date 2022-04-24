{ pkgs, stdenv, fetchFromGitHub, postgresql }:

stdenv.mkDerivation rec {
  name = "postgresql_ip4r-${version}";
  version = "2.4.1";

  src = fetchFromGitHub {
    owner = "RhodiumToad";
    repo = "ip4r";
    rev = version;
    hash = "sha256-smK3LkgQS3HFbxxGXg0vLuHjWA58brjgTXL++SGu0uY=";
  };

  buildInputs = [ postgresql ];

  preConfigure = ''
    makeFlags="datadir=$out/share/postgresql docdir=$out/share/doc pkglibdir=$out/lib"
  '';

  installPhase = ''
    install -D ip4r.so -t $out/lib
    install -D scripts/ip4r--2.4.sql -t $out/share/postgresql/extension
    install -D ip4r.control -t $out/share/postgresql/extension
  '';
}
