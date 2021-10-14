{ stdenv, fetchurl, patchelf }:

stdenv.mkDerivation rec {
  name = "kibana-${version}";
  version = "7.15.1";

  src = fetchurl {
    url =
      "https://artifacts.elastic.co/downloads/kibana/kibana-${version}-linux-x86_64.tar.gz";
    sha256 = "16i5m1vzcnrrrr9g42mw4xysqa9zr29b190yj4ql899v0z6psj2f";
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
