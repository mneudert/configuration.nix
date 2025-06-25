{
  stdenv,
  fetchurl,
  patchelf,
}:

stdenv.mkDerivation rec {
  name = "kibana-${version}";
  version = "9.0.3";

  src = fetchurl {
    url = "https://artifacts.elastic.co/downloads/kibana/kibana-${version}-linux-x86_64.tar.gz";
    hash = "sha256-pgilfvx5EugtKY3N8nVRfdkdTCIbp67rf3DOxpgj3T8=";
  };

  installPhase = ''
    mkdir -p $out
    cp -R * $out

    patchelf \
        --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
        --set-rpath "${stdenv.cc.cc.lib}/lib" \
        $out/node/*/bin/node
  '';
}
