{ stdenv, fetchurl, zlib, autoPatchelfHook, oss ? true }:

with stdenv.lib;
let
  package = if oss then "elasticsearch-oss" else "elasticsearch";
  hash =
    if oss then
      "038rw7i52vvf306593l3g05dfivxwx6y0mk18x60s5bg7v9s1ia3"
    else
      "1fcn9rbz9xyykjrrdiyazqijij4j518bpahw453c28wqjqc8x178";
in stdenv.mkDerivation rec {
  name = "${package}-${version}";
  version = "7.10.0";

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
