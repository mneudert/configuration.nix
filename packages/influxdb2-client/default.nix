{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb2-client-${version}";
  version = "2.6.1";

  src = fetchurl {
    url =
      "https://dl.influxdata.com/influxdb/releases/influxdb2-client-${version}-linux-amd64.tar.gz";
    hash = "sha256-OPODChPrMaWHNsW3Bjo21L64dsbFVWwp9/xKl0+/t8E=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R influx $out/bin
  '';
}
