{ stdenv, fetchurl, makeWrapper, jre, utillinux }:

stdenv.mkDerivation rec {
  name    = "elasticsearch-${version}";
  version = "7.0.0-alpha2";

  src = fetchurl {
    url = "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-${version}.tar.gz";
    sha256 = "1j92mi11bbigvbzzbvjyrncq2z869qc1kkik4fa18wwkz17a8ayw";
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
