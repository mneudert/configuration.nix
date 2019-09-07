{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name = "influxdb-${version}";
  version = "1.7.8";

  src = fetchFromGitHub {
    owner = "influxdata";
    repo = "influxdb";
    rev = "v${version}";
    sha256 = "117crqydfpnr2jb3g6pl1rllr3sc45w94vb3ijvviqcgg66sv9yk";
  };

  goDeps =  ./deps.nix;
  goPackagePath = "github.com/influxdata/influxdb";

  excludedPackages = "test";

  patchPhase = ''
    sed -i -e 's/version = "unknown"/version = "${version}"/g' ./cmd/influxd/main.go
  '';
}
