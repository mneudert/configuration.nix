{ stdenv, fetchurl, patchelf }:

stdenv.mkDerivation rec {
  name = "kibana-${version}";
  version = "8.14.3";

  src = fetchurl {
    url =
      "https://artifacts.elastic.co/downloads/kibana/kibana-${version}-linux-x86_64.tar.gz";
    hash = "sha256-0w6d4InhvMaBtqClu2FPSPeQYRZSBrxNaaO8A2T3gD4=";
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
