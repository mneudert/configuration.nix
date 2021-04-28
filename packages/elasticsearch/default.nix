{ stdenv, fetchurl, zlib, autoPatchelfHook }:

stdenv.mkDerivation rec {
  name = "elasticsearch-${version}";
  version = "7.12.1";

  src = fetchurl {
    url = "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${version}-linux-x86_64.tar.gz";
    sha256 = "0j1wilhna8ws6s5sc54a3pvh9dd7acq7v3z9c1rv6v6k2w4r5bgv";
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
