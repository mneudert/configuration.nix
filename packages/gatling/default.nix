{ stdenv, fetchzip, makeWrapper, jre }:

stdenv.mkDerivation rec {
  name    = "gatling-${version}";
  version = "3.0.1";

  src = fetchzip {
    url    = "https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/${version}/gatling-charts-highcharts-bundle-${version}-bundle.zip";
    sha256 = "192l6csnmfn4iv3v9n9ly97r0xbdfxaipxxzd53f6ks4w651j0ik";
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
