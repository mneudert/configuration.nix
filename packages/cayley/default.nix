{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name    = "cayley-${version}";
  version = "0.7.2";

  src = fetchFromGitHub {
    owner  = "cayleygraph";
    repo   = "cayley";
    rev    = "v${version}";
    sha256 = "1y8yxl92bn70wkid4x9chxlg2b8nhimn0vsb50spbballqy90f00";
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
