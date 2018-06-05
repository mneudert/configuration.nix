{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name    = "cayley-${version}";
  version = "0.7.4";

  src = fetchFromGitHub {
    owner  = "cayleygraph";
    repo   = "cayley";
    rev    = "v${version}";
    sha256 = "0bqisl0a4x7fq8wq3n1d05mpgdj9pppnpzxgkxarxy9x52f56xah";
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
