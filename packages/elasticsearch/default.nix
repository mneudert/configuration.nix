{ stdenv, fetchurl, makeWrapper, jre, utillinux }:

stdenv.mkDerivation rec {
  name    = "elasticsearch-${version}";
  version = "6.4.2";

  src = fetchurl {
    url = "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-${version}.tar.gz";
    sha256 = "11p4wgipq3337174vhx90qzsdn2q4l3rnwssqddf80zfsh7s16n5";
  };

  patches = [
    ./elasticsearch-env.patch
  ];

  buildInputs = [ makeWrapper jre utillinux ];

  installPhase = ''
    mkdir -p $out
    cp -R bin config lib modules $out

    wrapProgram $out/bin/elasticsearch \
        --prefix ES_CLASSPATH : "$out/lib/*" \
        --prefix PATH : "${utillinux}/bin/" \
        --set JAVA_HOME "${jre}"

    wrapProgram $out/bin/elasticsearch-plugin --set JAVA_HOME "${jre}"
  '';
}
