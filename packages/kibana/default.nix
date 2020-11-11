{ stdenv, fetchurl, patchelf, oss ? true }:

let
  package = if oss then "kibana-oss" else "kibana";
  hash =
    if oss then
      "1h6ybjs87l5nr6gk2qx8p886dgdi48jgykm400mwlixa1amkawrw"
    else
      "06fyj6mza7rxfqq83h9n7ai7dlf2gq5hdv9cwzcrq5dh8swp6lys";
in stdenv.mkDerivation rec {
  name = "${package}-${version}";
  version = "7.10.0";

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
