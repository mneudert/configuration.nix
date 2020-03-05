{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb-${version}";
  version = "2.0.0-beta.5";

  src = fetchurl {
    url = "https://dl.influxdata.com/influxdb/releases/influxdb_${version}_linux_amd64.tar.gz";
    sha256 = "1vqi71vnamrjq75pwmljw0z6hplfq3yikrm1pm71vx64hcd7xp7m";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R * $out/bin
  '';
}
