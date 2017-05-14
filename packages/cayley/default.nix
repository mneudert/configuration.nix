{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name    = "cayley-${version}";
  version = "0.6.1";

  src = fetchFromGitHub {
    owner  = "cayleygraph";
    repo   = "cayley";
    rev    = "v${version}";
    sha256 = "1r0kw3y32bqm7g37svzrch2qj9n45p93xmsrf7dj1cg4wwkb65ry";
  };

  patches = [
    ./cayley-assets.patch
  ];

  goDeps        = ./deps.nix;
  goPackagePath = "github.com/cayleygraph/cayley";

  preBuild =
    ''
      pushd ./go/src/github.com/cayleygraph/cayley/internal/http/
        sed -i 's@__NIXOS_BIN__@'$bin'@g' http.go
      popd
    '';

  postInstall =
    ''
      pushd ./go/src/github.com/cayleygraph/cayley/
        mkdir $bin/assets
        cp -R ./docs ./static ./templates $bin/assets/
      popd
    '';
}
