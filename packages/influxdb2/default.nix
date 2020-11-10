{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb-${version}";
  version = "2.0.0";

  src = fetchurl {
    url = "https://dl.influxdata.com/influxdb/releases/influxdb-${version}_linux_amd64.tar.gz";
    sha256 = "1ckm36ylgg9lr6fqggqmhqcx6yf8isbai4xkql762ic2id8v2l3l";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R * $out/bin
  '';
}
