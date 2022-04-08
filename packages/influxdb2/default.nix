{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb2-${version}";
  version = "2.2.0";

  src = fetchurl {
    url =
      "https://dl.influxdata.com/influxdb/releases/influxdb2-${version}-linux-amd64.tar.gz";
    hash = "sha256-h8nkw1YnESDneSsPxDerrGyJM/vVbWxFiTchGYI8r1g=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R influxd $out/bin
  '';
}
