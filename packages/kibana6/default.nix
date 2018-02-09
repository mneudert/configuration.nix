{ stdenv, fetchurl, makeWrapper, nodejs, jre, utillinux }:

stdenv.mkDerivation rec {
  name    = "kibana-${version}";
  version = "6.2.0";

  src = fetchurl {
    url = "https://artifacts.elastic.co/downloads/kibana/kibana-${version}-linux-x86_64.tar.gz";
    sha256 = "0dswi9alldsx116cy5prm9w1vr0m116di8z39s9y6wqy84rn02sw";
  };

  buildInputs = [ makeWrapper jre utillinux nodejs ];

  installPhase = ''
    mkdir -p $out/libexec/kibana $out/bin
    mv * $out/libexec/kibana/
    rm -r $out/libexec/kibana/node

    makeWrapper $out/libexec/kibana/bin/kibana $out/bin/kibana \
      --prefix PATH : "${stdenv.lib.makeBinPath [ nodejs ]}"

    sed -i 's@NODE=.*@NODE=${nodejs}/bin/node@' $out/libexec/kibana/bin/kibana
  '';
}
