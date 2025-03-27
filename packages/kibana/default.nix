{
  stdenv,
  fetchurl,
  patchelf,
}:

stdenv.mkDerivation rec {
  name = "kibana-${version}";
  version = "8.17.4";

  src = fetchurl {
    url = "https://artifacts.elastic.co/downloads/kibana/kibana-${version}-linux-x86_64.tar.gz";
    hash = "sha256-6RtBerP3sgl1D0FyEtyGtDQU61308QoT8wa33zEN48c=";
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
