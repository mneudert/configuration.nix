{ stdenv, fetchurl, patchelf, oss ? true }:

let
  package = if oss then "kibana-oss" else "kibana";
  hash =
    if oss then
      "1ybd8hmigd0ac2q1b1081xf3facmx2qlzqk8p0yx48bcb4awhgxb"
    else
      "1mnxzw6is7n41v78hdi32sdy0zfv10wis39973770wki9w46w410";
in stdenv.mkDerivation rec {
  name = "${package}-${version}";
  version = "7.9.3";

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
