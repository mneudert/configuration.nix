{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb-${version}";
  version = "2.0.1";

  src = fetchurl {
    url = "https://dl.influxdata.com/influxdb/releases/influxdb-${version}_linux_amd64.tar.gz";
    sha256 = "17p4pizv1i9gipkzbha29l1hyaqf2d23441zxqgzgrrck0px84jq";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R * $out/bin
  '';
}
