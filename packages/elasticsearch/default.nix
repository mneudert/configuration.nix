{ stdenv, fetchurl, zlib, autoPatchelfHook, oss ? true }:

with stdenv.lib;
let
  package = if oss then "elasticsearch-oss" else "elasticsearch";
  hash =
    if oss then
      "0swxxyzgzwplnl407wg4kvkxl8sn0n1vx7y3rzpmgknkc93naazw"
    else
      "0g3f9ix4839kcr7j292mfzj4c9l1rq3l1xk6hg893jnk55p3md51";
in stdenv.mkDerivation rec {
  name = "${package}-${version}";
  version = "7.9.1";

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
