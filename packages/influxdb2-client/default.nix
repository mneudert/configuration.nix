{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb2-client-${version}";
  version = "2.9.1";

  src = fetchurl {
    url = "https://dl.influxdata.com/influxdb/releases/influxdb2-client-${version}-linux-amd64.tar.gz";
    hash = "sha256-hQHqddHUjpwldNW/jSTvpCOPI90bbc5lumC+hQ8vS2M=";
  };

  setSourceRoot = "sourceRoot=`pwd`";

  installPhase = ''
    mkdir -p $out/bin
    cp -R influx $out/bin
  '';
}
