{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "cayley-${version}";
  version = "0.7.5";

  src = fetchurl {
    url = "https://github.com/cayleygraph/cayley/releases/download/v${version}/cayley_${version}_linux_amd64.tar.gz";
    sha256 = "1bq2gqbjljc0ws5lnfjvvhwhnykpq6k61mv2ccfm7hcqd9wgmhb9";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R * $out

    ln -s $out/cayley $out/bin/cayley
  '';
}
