{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb2-client-${version}";
  version = "2.7.1";

  src = fetchurl {
    url =
      "https://dl.influxdata.com/influxdb/releases/influxdb2-client-${version}_linux_amd64.tar.gz";
    hash = "sha256-61kv7pvdvEH8eC/2KWyPG4rFm2A56rCSNs5TodT7KGc=";
  };

  setSourceRoot = "sourceRoot=`pwd`";

  installPhase = ''
    mkdir -p $out/bin
    cp -R influx $out/bin
  '';
}
