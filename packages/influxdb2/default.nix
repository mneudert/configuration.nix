{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb-${version}";
  version = "2.0.0-beta.15";

  src = fetchurl {
    url = "https://dl.influxdata.com/influxdb/releases/influxdb_${version}_linux_amd64.tar.gz";
    sha256 = "1p4b71n23phsiqq0kg9vnqc337l2gkwbydcqnrvb66w9r3cjz90v";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R * $out/bin
  '';
}
