{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb2-${version}";
  version = "2.7.5";

  src = fetchurl {
    url =
      "https://dl.influxdata.com/influxdb/releases/influxdb2-${version}_linux_amd64.tar.gz";
    hash = "sha256-qCtHY0v0kltmxORhBX35ZSGi8fIl+dk+jXM5g+U/5Sk=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R usr/bin/influxd $out/bin
  '';
}
