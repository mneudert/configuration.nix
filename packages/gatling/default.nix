{ stdenv, fetchzip, makeWrapper, jdk }:

stdenv.mkDerivation rec {
  name = "gatling-${version}";
  version = "3.2.0";

  src = fetchzip {
    url = "https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/${version}/gatling-charts-highcharts-bundle-${version}-bundle.zip";
    sha256 = "04ihckf34wlal56n4frmny4ghj7yvgmg31rwrzqvn1d5hm7zgxy2";
  };

  buildInputs = [ makeWrapper jdk ];

  buildPhase = "patchShebangs bin";
  installPhase = ''
    mkdir -p $out
    cp -R LICENSE bin conf lib results user-files $out

    wrapProgram $out/bin/gatling.sh --set JAVA_HOME "${jdk}"
    wrapProgram $out/bin/recorder.sh --set JAVA_HOME "${jdk}"
  '';
}
