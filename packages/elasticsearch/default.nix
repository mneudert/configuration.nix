{ stdenv, fetchurl, zlib, autoPatchelfHook, oss ? true }:

with stdenv.lib;
let
  package = if oss then "elasticsearch-oss" else "elasticsearch";
  hash =
    if oss then
      "1x51l7c9705jrqrb5mwh4pbypszm1f8s2m71apv9xspnpzj4gmq7"
    else
      "0yd3k6hsr24idv1z99slrpr413pmdiql6nxxn28wdl6hihqfg34z";
in stdenv.mkDerivation rec {
  name = "${package}-${version}";
  version = "7.9.0";

  src = fetchurl {
    url = "https://artifacts.elastic.co/downloads/elasticsearch/${package}-${version}-linux-x86_64.tar.gz";
    sha256 = hash;
  };

  patches = [
    ./elasticsearch-env.patch
  ];

  dontPatchELF = true;
  dontAutoPatchelf = true;
  buildInputs = [ zlib ];
  runtimeDependencies = [ zlib ];
  nativeBuildInputs = [ autoPatchelfHook ];

  installPhase = ''
    mkdir -p $out
    cp -R bin config jdk lib modules $out

    for exe in $(find $out/jdk/ -type f -executable); do
      patchelf \
          --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
          --set-rpath "$(patchelf --print-rpath "$exe"):${zlib}/lib" \
          "$exe"
    done
  '';

  postFixup = ''
    if [ -d "$out/modules/x-pack-ml/platform/linux-x86_64" ]; then
      autoPatchelf "$out/modules/x-pack-ml/platform/linux-x86_64"
    fi
  '';
}
