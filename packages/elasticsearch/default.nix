{
  stdenv,
  fetchurl,
  zlib,
  autoPatchelfHook,
}:

stdenv.mkDerivation rec {
  name = "elasticsearch-${version}";
  version = "9.2.4";

  src = fetchurl {
    url = "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${version}-linux-x86_64.tar.gz";
    hash = "sha256-erTG61OWTAFQRAzV7eWzX9GaadsHzWNosIX680kzF7Y=";
  };

  patches = [ ./elasticsearch-env.patch ];

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
      if [ -f "$out/modules/x-pack-ml/platform/linux-x86_64/lib/libboost_context-gcc10-mt-x64-1_71.so" ]; then
        if [ ! -f "$out/modules/x-pack-ml/platform/linux-x86_64/lib/libboost_context-gcc10-mt-x64-1_71.so.1.71.0" ]; then
          cp \
            "$out/modules/x-pack-ml/platform/linux-x86_64/lib/libboost_context-gcc10-mt-x64-1_71.so" \
            "$out/modules/x-pack-ml/platform/linux-x86_64/lib/libboost_context-gcc10-mt-x64-1_71.so.1.71.0"
        fi
      fi

      if [ -f "$out/modules/x-pack-ml/platform/linux-x86_64/lib/libboost_serialization-gcc10-mt-x64-1_71.so" ]; then
        if [ ! -f "$out/modules/x-pack-ml/platform/linux-x86_64/lib/libboost_serialization-gcc10-mt-x64-1_71.so.1.71.0" ]; then
          cp \
            "$out/modules/x-pack-ml/platform/linux-x86_64/lib/libboost_serialization-gcc10-mt-x64-1_71.so" \
            "$out/modules/x-pack-ml/platform/linux-x86_64/lib/libboost_serialization-gcc10-mt-x64-1_71.so.1.71.0"
        fi
      fi

      autoPatchelf "$out/modules/x-pack-ml/platform/linux-x86_64"
    fi
  '';
}
