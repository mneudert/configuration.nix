{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "cayley-${version}";
  version = "0.7.7";

  src = fetchurl {
    url = "https://github.com/cayleygraph/cayley/releases/download/v${version}/cayley_${version}_linux_amd64.tar.gz";
    sha256 = "1hm69hhrw5x9qrd8174lw619v8kb42dbrm3xh7m31va9lpsllq62";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R * $out

    ln -s $out/cayley $out/bin/cayley
  '';
}
