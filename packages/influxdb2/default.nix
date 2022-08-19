{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb2-${version}";
  version = "2.4.0";

  src = fetchurl {
    url =
      "https://dl.influxdata.com/influxdb/releases/influxdb2-${version}-linux-amd64.tar.gz";
    hash = "sha256-Ud3UmkgkkHUmR6TxNMPIOK2rZJA/Km7ZyQ2v+EGLfFg=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R influxd $out/bin
  '';
}
