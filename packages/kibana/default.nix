{
  stdenv,
  fetchurl,
  patchelf,
}:

stdenv.mkDerivation rec {
  name = "kibana-${version}";
  version = "9.3.2";

  src = fetchurl {
    url = "https://artifacts.elastic.co/downloads/kibana/kibana-${version}-linux-x86_64.tar.gz";
    hash = "sha256-dR2wI7IgeD8u88JKTnchH/yi6pkHzNgpdxG0tWCi+0s=";
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
