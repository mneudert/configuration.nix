{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name    = "cayley-${version}";
  version = "0.7.0";

  src = fetchFromGitHub {
    owner  = "cayleygraph";
    repo   = "cayley";
    rev    = "v${version}";
    sha256 = "1npsq53cidl3vr7609rnzlma4hxdgcsi9ampp0kp57apjay2ah9g";
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
