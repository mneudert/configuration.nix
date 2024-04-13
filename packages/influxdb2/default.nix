{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb2-${version}";
  version = "2.7.6";

  src = fetchurl {
    url =
      "https://dl.influxdata.com/influxdb/releases/influxdb2-${version}_linux_amd64.tar.gz";
    hash = "sha256-op1W29GO3uuJP2H6BRf12RQNLgc/Ls+AWRL0uR8wiCU=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R usr/bin/influxd $out/bin
  '';
}
