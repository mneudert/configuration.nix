{ stdenv, fetchurl, makeWrapper, jre, utillinux }:

stdenv.mkDerivation rec {
  name = "elasticsearch-${version}";
  version = "7.0.0";

  src = fetchurl {
    url = "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-${version}-linux-x86_64.tar.gz";
    sha256 = "1jrcdxm1swf8ahkv3h7kyzzhdq9nwwfhimpflzdq2d831fx525y8";
  };

  patches = [
    ./elasticsearch-env.patch
  ];

  buildInputs = [ makeWrapper jre utillinux ];

  installPhase = ''
    mkdir -p $out
    cp -R bin config lib modules $out

    wrapProgram $out/bin/elasticsearch \
        --prefix ES_CLASSPATH : "$out/lib/*" \
        --prefix PATH : "${utillinux}/bin/" \
        --set JAVA_HOME "${jre}"

    wrapProgram $out/bin/elasticsearch-plugin --set JAVA_HOME "${jre}"
  '';
}
