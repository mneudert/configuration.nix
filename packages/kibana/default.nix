{ stdenv, fetchurl, patchelf }:

stdenv.mkDerivation rec {
  name = "kibana-${version}";
  version = "7.4.0";

  src = fetchurl {
    url = "https://artifacts.elastic.co/downloads/kibana/kibana-oss-${version}-linux-x86_64.tar.gz";
    sha256 = "14msp8zqgcrfrl2ca7a1l3r4wpahipra81l6c8zni11wcl79rw6b";
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
