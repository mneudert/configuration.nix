{ stdenv, fetchurl, patchelf, zlib }:

stdenv.mkDerivation rec {
  name = "elasticsearch-${version}";
  version = "7.3.2";

  src = fetchurl {
    url = "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-${version}-linux-x86_64.tar.gz";
    sha256 = "0m2rpcylil90gbjn0dks9z196xz260jaxig3d298vf3r6amgagia";
  };

  patches = [
    ./elasticsearch-env.patch
  ];

  buildInputs = [ zlib ];

  installPhase = ''
    mkdir -p $out
    cp -R bin config jdk lib modules $out

    patchelf \
        --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
        --set-rpath "$(patchelf --print-rpath "$out/jdk/bin/java"):${zlib}/lib" \
        "$out/jdk/bin/java"
  '';
}
