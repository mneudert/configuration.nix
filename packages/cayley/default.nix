{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "cayley-${version}";
  version = "0.7.7";

  src = fetchurl {
    url = "https://github.com/cayleygraph/cayley/releases/download/v${version}/cayley_${version}_linux_amd64.tar.gz";
    hash = "sha256-wmBK9aVJ7TDqgX3UvJoga6KdguGUnIBaxqkXniFMpsI=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R * $out

    ln -s $out/cayley $out/bin/cayley
  '';
}
