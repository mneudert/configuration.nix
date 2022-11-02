{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb2-${version}";
  version = "2.5.0";

  src = fetchurl {
    url =
      "https://dl.influxdata.com/influxdb/releases/influxdb2-${version}-linux-amd64.tar.gz";
    hash = "sha256-dzYwZEg7hC7PiMF1tK/Am2RBVtAfQi+1LxRIwKy51pQ=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R influxd $out/bin
  '';
}
