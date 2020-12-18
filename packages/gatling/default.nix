{ stdenv, fetchzip, makeWrapper, jdk }:

stdenv.mkDerivation rec {
  name = "gatling-${version}";
  version = "3.5.0";

  src = fetchzip {
    url = "mirror://maven/io/gatling/highcharts/gatling-charts-highcharts-bundle/${version}/gatling-charts-highcharts-bundle-${version}-bundle.zip";
    sha256 = "1pjynzygf3wwh5dsv4ipnk2ka2bxk4dxm4g82qa4i4pqljj0w7s5";
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
