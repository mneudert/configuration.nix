{ stdenv, fetchurl, zlib, autoPatchelfHook, oss ? true }:

with stdenv.lib;
let
  package = if oss then "elasticsearch-oss" else "elasticsearch";
  hash =
    if oss then
      "1y5p9mhs3dznj3lcb4mr3jrhpxv07wg9jdp77fsa97m465hm6cbn"
    else
      "0p0w3hk2gi8w54jf9vn171pqnbvv0jnlyv9zbwc6g9dhhv55v0df";
in stdenv.mkDerivation rec {
  name = "${package}-${version}";
  version = "7.9.3";

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
