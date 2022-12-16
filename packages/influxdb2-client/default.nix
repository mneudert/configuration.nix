{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb2-client-${version}";
  version = "2.6.0";

  src = fetchurl {
    url =
      "https://dl.influxdata.com/influxdb/releases/influxdb2-client-${version}-linux-amd64.tar.gz";
    hash = "sha256-xJF/rAzCNeb8yJMWHV8hRvNW+HqAQhcPslbh7gldvPs=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R influx $out/bin
  '';
}
