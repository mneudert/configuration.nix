{ stdenv, fetchzip, makeWrapper, jre }:

stdenv.mkDerivation rec {
  name    = "gatling";
  version = "2.2.5";

  src = fetchzip {
    url    = "https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/${version}/gatling-charts-highcharts-bundle-${version}-bundle.zip";
    sha256 = "10wh5izdsk2nmcaq8r8640s58cmbhz96ymv6qxvzs4shrcf7ivyb";
  };

  patches = [
    ./gatling-classpath.patch
  ];

  buildInputs = [ makeWrapper jre ];

  buildPhase   = "patchShebangs bin";
  installPhase = ''
    mkdir -p $out
    cp -R LICENSE bin conf lib results user-files $out

    wrapProgram $out/bin/gatling.sh --set JAVA_HOME "${jre}"
    wrapProgram $out/bin/recorder.sh --set JAVA_HOME "${jre}"
  '';
}
