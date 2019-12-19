{ stdenv, fetchurl, patchelf }:

stdenv.mkDerivation rec {
  name = "kibana-${version}";
  version = "7.5.1";

  src = fetchurl {
    url = "https://artifacts.elastic.co/downloads/kibana/kibana-oss-${version}-linux-x86_64.tar.gz";
    sha256 = "0ygpmcm6wdcnvw8azwqc5257lyic7yw31rqvm2pw3afhpha62lpj";
  };

  installPhase = ''
    mkdir -p $out
    cp -R * $out

    patchelf \
        --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
        --set-rpath "${stdenv.cc.cc.lib}/lib" \
        "$out/node/bin/node"
 '';
}
