{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name = "cayley-${version}";
  version = "0.7.5";

  src = fetchFromGitHub {
    owner = "cayleygraph";
    repo = "cayley";
    rev = "v${version}";
    sha256 = "1zfxa9z6spi6xw028mvbc7c3g517gn82g77ywr6picl47fr2blnd";
  };

  goDeps = ./deps.nix;
  goPackagePath = "github.com/cayleygraph/cayley";

  postInstall =
    ''
      pushd ./go/src/github.com/cayleygraph/cayley/ > /dev/null
        mkdir $bin/assets
        cp -R ./docs ./static ./templates $bin/assets/
      popd > /dev/null
    '';
}
