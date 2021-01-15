{ stdenv, fetchurl, patchelf, oss ? true }:

let
  package = if oss then "kibana-oss" else "kibana";
  hash =
    if oss then
      "050rhx82rqpgqssp1rdflz1ska3f179kd2k2xznb39614nk0m6gs"
    else
      "06p0v39ih606mdq2nsdgi5m7y1iynk9ljb9457h5rrx6jakc2cwm";
in stdenv.mkDerivation rec {
  name = "${package}-${version}";
  version = "7.10.2";

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
