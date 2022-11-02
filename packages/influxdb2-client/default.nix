{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb2-client-${version}";
  version = "2.5.0";

  src = fetchurl {
    url =
      "https://dl.influxdata.com/influxdb/releases/influxdb2-client-${version}-linux-amd64.tar.gz";
    hash = "sha256-45e2WbOB9/XogebM2bEzZQuQGEmHw93c6/zQ+Mo8WlY=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R influx $out/bin
  '';
}
