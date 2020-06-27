{ stdenv, fetchurl, patchelf, oss ? true }:

let
  package = if oss then "kibana-oss" else "kibana";
  hash =
    if oss then
      "0rnw4bkmiygy19wx57csy72n7piwzksh623j0nkqilbivwvajabi"
    else
      "0xnh07n894f170ahawcg03jm3xk4qpjjbfwkvd955vdgihpy60gh";
in stdenv.mkDerivation rec {
  name = "${package}-${version}";
  version = "7.8.0";

  src = fetchurl {
    url = "https://artifacts.elastic.co/downloads/kibana/${package}-${version}-linux-x86_64.tar.gz";
    sha256 = hash;
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
