{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name    = "cayley-${version}";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner  = "cayleygraph";
    repo   = "cayley";
    rev    = "v${version}";
    sha256 = "1mva4p1sbwv150ifnrhm83xn416pmnbrr4dzarwzx6zy1fyws555";
  };

  patches = [
    ./cayley-assets.patch
  ];

  goDeps        = ./. + builtins.toPath "/cayley-deps.nix";
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
