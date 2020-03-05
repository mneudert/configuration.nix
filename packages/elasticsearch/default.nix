{ stdenv, fetchurl, zlib }:

stdenv.mkDerivation rec {
  name = "elasticsearch-${version}";
  version = "7.6.1";

  src = fetchurl {
    url = "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-${version}-linux-x86_64.tar.gz";
    sha256 = "08v421fh3ks1s2xd1ch8wrx1n6vc8mgwf20ng40xif2viryr9hfd";
  };

  patches = [
    ./elasticsearch-env.patch
  ];

  buildInputs = [ zlib ];

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
}
