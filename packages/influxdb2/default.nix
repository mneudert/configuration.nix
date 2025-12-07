{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb2-${version}";
  version = "2.8.0";

  src = fetchurl {
    url = "https://dl.influxdata.com/influxdb/releases/v${version}/influxdb2-${version}_linux_amd64.tar.gz";
    hash = "sha256-3yjLnTy0dzKQhgTZY7ICcaP7DoP0GJdsxIL5keMolX0=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R influxd $out/bin
  '';
}
