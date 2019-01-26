{ stdenv, fetchzip, makeWrapper, jdk }:

stdenv.mkDerivation rec {
  name    = "gatling-${version}";
  version = "3.0.3";

  src = fetchzip {
    url    = "https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/${version}/gatling-charts-highcharts-bundle-${version}-bundle.zip";
    sha256 = "0vp9k9l5x1qbyi5v03cs68i6zjxrydyzmcpcs2hhzf90jfqrchpb";
  };

  buildInputs = [ makeWrapper jdk ];

  buildPhase   = "patchShebangs bin";
  installPhase = ''
    mkdir -p $out
    cp -R LICENSE bin conf lib results user-files $out

    wrapProgram $out/bin/gatling.sh --set JAVA_HOME "${jdk}"
    wrapProgram $out/bin/recorder.sh --set JAVA_HOME "${jdk}"
  '';
}
