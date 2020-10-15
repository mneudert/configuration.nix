{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb-${version}";
  version = "2.0.0-rc.1";

  src = fetchurl {
    url = "https://dl.influxdata.com/influxdb/releases/influxdb-${version}_linux_amd64.tar.gz";
    sha256 = "0mrjxdz4fnp9rx8dd14kqizk3pks4ij4w2gf7zszfpb4747pwd0z";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R * $out/bin
  '';
}
