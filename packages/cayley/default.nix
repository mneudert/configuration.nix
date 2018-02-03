{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name    = "cayley-${version}";
  version = "0.7.1";

  src = fetchFromGitHub {
    owner  = "cayleygraph";
    repo   = "cayley";
    rev    = "v${version}";
    sha256 = "1m0lmqyq9kak7avvgmm57rp593iw6qv2dy2nbhn5fc49p9m0vnn7";
  };

  goDeps        = ./deps.nix;
  goPackagePath = "github.com/cayleygraph/cayley";

  postInstall =
    ''
      pushd ./go/src/github.com/cayleygraph/cayley/
        mkdir $bin/assets
        cp -R ./docs ./static ./templates $bin/assets/
      popd
    '';
}
