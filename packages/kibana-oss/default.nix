{ stdenv, fetchurl, patchelf }:

stdenv.mkDerivation rec {
  name = "kibana-oss-${version}";
  version = "7.10.2";

  src = fetchurl {
    url =
      "https://artifacts.elastic.co/downloads/kibana/kibana-oss-${version}-linux-x86_64.tar.gz";
    hash = "sha256-+pkKpiXBpLHs72KKNtMJbqipw6eu5XC1xu/iLFCHGRQ=";
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
