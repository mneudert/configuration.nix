{ stdenv, fetchurl, makeWrapper, nodejs, jre, utillinux }:

stdenv.mkDerivation rec {
  name    = "kibana-${version}";
  version = "6.2.3";

  src = fetchurl {
    url = "https://artifacts.elastic.co/downloads/kibana/kibana-${version}-linux-x86_64.tar.gz";
    sha256 = "15iykvbqgqj9lk764rkl52f47b6v59kvfiqfvdp3n3anszyqcc5d";
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
