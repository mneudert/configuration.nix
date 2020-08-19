{ stdenv, fetchurl, patchelf, oss ? true }:

let
  package = if oss then "kibana-oss" else "kibana";
  hash =
    if oss then
      "0vb6y9xrzkhbggs9p51qkbyci1cnkxh2hlradj9ckvvvar435d4s"
    else
      "0dbx78xx2xn0bab64s81piy75nwvrhlq77adlcxqihcjr0la4hn1";
in stdenv.mkDerivation rec {
  name = "${package}-${version}";
  version = "7.9.0";

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
