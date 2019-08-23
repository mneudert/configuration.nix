{ stdenv, fetchurl, makeWrapper, jre, utillinux }:

stdenv.mkDerivation rec {
  name = "elasticsearch-${version}";
  version = "7.3.1";

  src = fetchurl {
    url = "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-${version}-linux-x86_64.tar.gz";
    sha256 = "1nl6yic1j422l2c7mf8wv0ylfx6marrwm7d181z9nzdswq509kpg";
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
