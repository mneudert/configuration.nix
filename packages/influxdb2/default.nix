{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb2-${version}";
  version = "2.7.8";

  src = fetchurl {
    url =
      "https://dl.influxdata.com/influxdb/releases/influxdb2-${version}_linux_amd64.tar.gz";
    hash = "sha256-F7KQWRL9Z3xxV1XPlT9UprE/Uo2iaLzYVLQ2iXmDKvg=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R usr/bin/influxd $out/bin
  '';
}
