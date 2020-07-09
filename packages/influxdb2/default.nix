{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "influxdb-${version}";
  version = "2.0.0-beta.14";

  src = fetchurl {
    url = "https://dl.influxdata.com/influxdb/releases/influxdb_${version}_linux_amd64.tar.gz";
    sha256 = "1zvs9f9nqjx7xhq2ikprb99nf7z50d8dwnlmvfvhjph267m9l667";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R * $out/bin
  '';
}
