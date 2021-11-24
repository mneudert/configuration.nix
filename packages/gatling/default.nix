{ stdenv, fetchzip, makeWrapper, jdk }:

stdenv.mkDerivation rec {
  name = "gatling-${version}";
  version = "3.7.1";

  src = fetchzip {
    url =
      "mirror://maven/io/gatling/highcharts/gatling-charts-highcharts-bundle/${version}/gatling-charts-highcharts-bundle-${version}-bundle.zip";
    sha256 = "1ril3z4q8l1n13sf270w36cfa445k0n7sm73l3zqfcwvsjpws60m";
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
