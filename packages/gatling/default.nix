{ stdenv, fetchzip, makeWrapper, jre }:

stdenv.mkDerivation rec {
  name    = "gatling-${version}";
  version = "2.3.1";

  src = fetchzip {
    url    = "https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/${version}/gatling-charts-highcharts-bundle-${version}-bundle.zip";
    sha256 = "08npxmwc57wdlwchvd7zn5mz8srbx5q1fp0nwbrr018mch3khm0p";
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
