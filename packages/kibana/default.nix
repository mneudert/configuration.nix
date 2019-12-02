{ stdenv, fetchurl, patchelf }:

stdenv.mkDerivation rec {
  name = "kibana-${version}";
  version = "7.5.0";

  src = fetchurl {
    url = "https://artifacts.elastic.co/downloads/kibana/kibana-oss-${version}-linux-x86_64.tar.gz";
    sha256 = "01wm5fphjz37mq3vnay4qy4l512fs6v0vnkwkj85dns602l64fgx";
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
