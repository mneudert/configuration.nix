{ stdenv, fetchurl, patchelf }:

stdenv.mkDerivation rec {
  name = "kibana-${version}";
  version = "7.6.1";

  src = fetchurl {
    url = "https://artifacts.elastic.co/downloads/kibana/kibana-oss-${version}-linux-x86_64.tar.gz";
    sha256 = "1aphj5dqjcn8jq1m75gma0flsfxh1qj84v6nymwl6qdjqi70x0bf";
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
