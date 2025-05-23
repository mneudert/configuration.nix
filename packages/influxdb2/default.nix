{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb2-${version}";
  version = "2.7.12";

  src = fetchurl {
    url = "https://dl.influxdata.com/influxdb/releases/v${version}/influxdb2-${version}_linux_amd64.tar.gz";
    hash = "sha256-glZB5ni0oPbiCUKT8ya0ciafMMPQKpib7ow3v6cG+Nc=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R usr/bin/influxd $out/bin
  '';
}
