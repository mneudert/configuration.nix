{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb-${version}";
  version = "2.0.0-rc.3";

  src = fetchurl {
    url = "https://dl.influxdata.com/influxdb/releases/influxdb-${version}_linux_amd64.tar.gz";
    sha256 = "16bs4a288kn5dy0ah3q45yk6gw7z4fzm1xvnxx5ag4i7fafz69ll";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R * $out/bin
  '';
}
