{ stdenv, fetchzip, makeWrapper, jdk }:

stdenv.mkDerivation rec {
  name = "gatling-${version}";
  version = "3.7.5";

  src = fetchzip {
    url =
      "mirror://maven/io/gatling/highcharts/gatling-charts-highcharts-bundle/${version}/gatling-charts-highcharts-bundle-${version}-bundle.zip";
    hash = "sha256-HIqEpe8OKjym1GymMRcA1PvxOOfX6Gi2fbLY7Fkeq7A=";
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
