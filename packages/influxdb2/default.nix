{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb2-${version}";
  version = "2.7.1";

  src = fetchurl {
    url =
      "https://dl.influxdata.com/influxdb/releases/influxdb2-${version}-linux-amd64.tar.gz";
    hash = "sha256-5ez8FcNa9VZB/8kmgK0PsEOqUalClEJS4hTipVHGDrs=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R influxd $out/bin
  '';
}
