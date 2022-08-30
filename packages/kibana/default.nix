{ stdenv, fetchurl, patchelf }:

stdenv.mkDerivation rec {
  name = "kibana-${version}";
  version = "8.4.1";

  src = fetchurl {
    url =
      "https://artifacts.elastic.co/downloads/kibana/kibana-${version}-linux-x86_64.tar.gz";
    hash = "sha256-LhX7dEvZeORyuIKRDsJWM7E2G8vbk7a5nsg3bifb414=";
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
