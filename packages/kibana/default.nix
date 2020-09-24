{ stdenv, fetchurl, patchelf, oss ? true }:

let
  package = if oss then "kibana-oss" else "kibana";
  hash =
    if oss then
      "1rf1ii0jlw3g13f6s0jzy76b3i30nz2lvgr3ink1bgmf8xjlsq9a"
    else
      "1kz65igz8awgdnw0hv8zwdwz53c6x9mvpifnhfff68ykj2ljmqiw";
in stdenv.mkDerivation rec {
  name = "${package}-${version}";
  version = "7.9.2";

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
