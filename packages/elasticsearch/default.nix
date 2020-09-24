{ stdenv, fetchurl, zlib, autoPatchelfHook, oss ? true }:

with stdenv.lib;
let
  package = if oss then "elasticsearch-oss" else "elasticsearch";
  hash =
    if oss then
      "0qh7i1gzwgs8xzvgrxrv968p5ibz9s5lh9c5x3jsak4w9j7a5rr1"
    else
      "0zg43vx3df0p1lh92766lgnyp5kw6s8vgydcqxpk4425d5xl00x0";
in stdenv.mkDerivation rec {
  name = "${package}-${version}";
  version = "7.9.2";

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
