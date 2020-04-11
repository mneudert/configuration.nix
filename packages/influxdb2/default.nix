{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb-${version}";
  version = "2.0.0-beta.8";

  src = fetchurl {
    url = "https://dl.influxdata.com/influxdb/releases/influxdb_${version}_linux_amd64.tar.gz";
    sha256 = "0vm70zs2gl8ps8wqdvp736w44g3wk2m89h7qc4gpm09mz4mvkmvd";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R * $out/bin
  '';
}
