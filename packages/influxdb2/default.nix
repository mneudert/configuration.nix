{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb-${version}";
  version = "2.0.2";

  src = fetchurl {
    url = "https://dl.influxdata.com/influxdb/releases/influxdb-${version}_linux_amd64.tar.gz";
    sha256 = "0c9zk26izqzylylk0aacxs5vl6aa02cc402s3sm42ra4vh8ls5h2";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R * $out/bin
  '';
}
