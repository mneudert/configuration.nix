{ stdenv, fetchzip, makeWrapper, jdk }:

stdenv.mkDerivation rec {
  name    = "gatling-${version}";
  version = "3.0.2";

  src = fetchzip {
    url    = "https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/${version}/gatling-charts-highcharts-bundle-${version}-bundle.zip";
    sha256 = "1khfx9xv4k7ml8wzm2kqli07rxw1saa7zgq73xaadsjw7h2zzx8h";
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
