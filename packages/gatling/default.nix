{ stdenv, fetchzip, makeWrapper, jre }:

stdenv.mkDerivation rec {
  name    = "gatling-${version}";
  version = "3.0.0";

  src = fetchzip {
    url    = "https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/${version}/gatling-charts-highcharts-bundle-${version}-bundle.zip";
    sha256 = "1qg59akibs5j602d2lzs704bm3f8c87v5awcdf27bji30snp9lwm";
  };

  buildInputs = [ makeWrapper jre ];

  buildPhase   = "patchShebangs bin";
  installPhase = ''
    mkdir -p $out
    cp -R LICENSE bin conf lib results user-files $out

    wrapProgram $out/bin/gatling.sh --set JAVA_HOME "${jre}"
    wrapProgram $out/bin/recorder.sh --set JAVA_HOME "${jre}"
  '';
}
