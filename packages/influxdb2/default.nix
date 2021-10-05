{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb2-${version}";
  version = "2.0.9";

  src = fetchurl {
    url =
      "https://dl.influxdata.com/influxdb/releases/influxdb2-${version}-linux-amd64.tar.gz";
    sha256 = "09lx5cvk6hqcqw7cripr3pbnm03zkrphack3l5wp982w3gmczfb4";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R * $out/bin
  '';
}
