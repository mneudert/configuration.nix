{ pkgs, stdenv, fetchFromGitHub, postgresql }:

stdenv.mkDerivation rec {
  name = "postgresql_ip4r-${version}";
  version = "2.4.2";

  src = fetchFromGitHub {
    owner = "RhodiumToad";
    repo = "ip4r";
    rev = version;
    hash = "sha256-3chAD4f4A6VlXVSI0kfC/ANcnFy4vBp4FZpT6QRAueQ=";
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
