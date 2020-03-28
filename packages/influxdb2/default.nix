{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb-${version}";
  version = "2.0.0-beta.7";

  src = fetchurl {
    url = "https://dl.influxdata.com/influxdb/releases/influxdb_${version}_linux_amd64.tar.gz";
    sha256 = "1m91mf85z1fdm81r5dqvpc70xj62pxbbz6xs7j4l4ak1c57an9hb";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R * $out/bin
  '';
}
