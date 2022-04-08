{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb2-client-${version}";
  version = "2.3.0";

  src = fetchurl {
    url =
      "https://dl.influxdata.com/influxdb/releases/influxdb2-client-${version}-linux-amd64.tar.gz";
    hash = "sha256-s+elxs4U3/f1KYQpvxzeDwevhnDRdnelMReoDs4532M=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R influx $out/bin
  '';
}
