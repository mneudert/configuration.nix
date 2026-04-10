{
  stdenv,
  fetchurl,
  lib,
}:

stdenv.mkDerivation rec {
  name = "influxdb3-${version}";
  version = "3.9.1";

  src = fetchurl {
    url = "https://dl.influxdata.com/influxdb/releases/influxdb3-core-${version}_linux_amd64.tar.gz";
    hash = "sha256-c+xgUb17v8De9cYQmBuxgBRIPqPRGxALsWZMF0H6rdM=";
  };

  dontPatchELF = true;
  dontAutoPatchelf = true;

  installPhase = ''
    mkdir -p $out/bin
    cp -R * $out/bin

    patchelf \
        --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      "$out/bin/influxdb3"
  '';
}
