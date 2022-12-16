{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb2-${version}";
  version = "2.6.0";

  src = fetchurl {
    url =
      "https://dl.influxdata.com/influxdb/releases/influxdb2-${version}-linux-amd64.tar.gz";
    hash = "sha256-qtzk04l4vAgesKqIzefyFOPPSKWSyIgQBqNjYyzDNzg=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R influxd $out/bin
  '';
}
