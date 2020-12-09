{ stdenv, fetchurl, patchelf, oss ? true }:

let
  package = if oss then "kibana-oss" else "kibana";
  hash =
    if oss then
      "089axbdsr5r5gj0jvv2gmh6vfrzw3nbcxzbs2cjmdf2fb8m9sfm2"
    else
      "19iqy3jhkk46dkdm5igg0xxhkf23g28sj4zdk25zjj9yrn1z377v";
in stdenv.mkDerivation rec {
  name = "${package}-${version}";
  version = "7.10.1";

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
