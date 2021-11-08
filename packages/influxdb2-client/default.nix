{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb2-client-${version}";
  version = "2.2.0";

  src = fetchurl {
    url =
      "https://dl.influxdata.com/influxdb/releases/influxdb2-client-${version}-linux-amd64.tar.gz";
    sha256 = "1j68mm40qcwfsni5bvwfhy5vgl7p0qgp9jn33s14mrhlxvwlhbk1";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R influx $out/bin
  '';
}
