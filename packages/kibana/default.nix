{ stdenv, fetchurl, patchelf }:

stdenv.mkDerivation rec {
  name = "kibana-${version}";
  version = "7.15.2";

  src = fetchurl {
    url =
      "https://artifacts.elastic.co/downloads/kibana/kibana-${version}-linux-x86_64.tar.gz";
    sha256 = "0m3bdfjbzg8zmrp580n6mlicgyzsafzn7zayq69dcl3jn52rak42";
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
