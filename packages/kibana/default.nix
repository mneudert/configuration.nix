{ stdenv, fetchurl, patchelf, oss ? true }:

let
  package = if oss then "kibana-oss" else "kibana";
  hash =
    if oss then
      "1r4b1j1szf8v65dgdgi8rhnzg537n7g6ivybnv5bz8lyqbjphc57"
    else
      "04f1fdld6w07pvqjz5ijmazdqk3jpkbl3kf5wiyx0fff3jify0qb";
in stdenv.mkDerivation rec {
  name = "${package}-${version}";
  version = "7.9.1";

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
