{ stdenv, fetchzip, makeWrapper, jdk }:

stdenv.mkDerivation rec {
  name = "gatling-${version}";
  version = "3.7.3";

  src = fetchzip {
    url =
      "mirror://maven/io/gatling/highcharts/gatling-charts-highcharts-bundle/${version}/gatling-charts-highcharts-bundle-${version}-bundle.zip";
    sha256 = "1y6nkq83d0jswlyx5gvbm2j8rw71b8nrj5vcz4msmlbkgmrjb21j";
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
