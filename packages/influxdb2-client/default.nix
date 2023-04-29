{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb2-client-${version}";
  version = "2.7.3";

  src = fetchurl {
    url =
      "https://dl.influxdata.com/influxdb/releases/influxdb2-client-${version}-linux-amd64.tar.gz";
    hash = "sha256-ombzBFR0Y7a8eIa/ReN9JSvMDOsxVquNeMUlYVWPv+Y=";
  };

  setSourceRoot = "sourceRoot=`pwd`";

  installPhase = ''
    mkdir -p $out/bin
    cp -R influx $out/bin
  '';
}
