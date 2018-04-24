{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name    = "cayley-${version}";
  version = "0.7.3";

  src = fetchFromGitHub {
    owner  = "cayleygraph";
    repo   = "cayley";
    rev    = "v${version}";
    sha256 = "1yyvnda1h71fd62rpiqy3lzxqcbrhcr60snrmjryv4ma51hqvv3n";
  };

  goDeps        = ./deps.nix;
  goPackagePath = "github.com/cayleygraph/cayley";

  postInstall =
    ''
      pushd ./go/src/github.com/cayleygraph/cayley/ > /dev/null
        mkdir $bin/assets
        cp -R ./docs ./static ./templates $bin/assets/
      popd > /dev/null
    '';
}
