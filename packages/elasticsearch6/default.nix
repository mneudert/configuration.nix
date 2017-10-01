{ stdenv, fetchurl, makeWrapper, jre, utillinux }:

stdenv.mkDerivation rec {
  name    = "elasticsearch-${version}";
  version = "6.0.0-rc1";

  src = fetchurl {
    url = "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${version}.tar.gz";
    sha256 = "0w55s3swgv3vwpgnbi7k4rc3v32jfsm4wyxwdsxq82mj40rh3z32";
  };

  patches = [
    ./elasticsearch6-env.patch
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
