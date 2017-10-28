{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name    = "influxdb-${version}";
  version = "1.3.7";

  src = fetchFromGitHub {
    owner  = "influxdata";
    repo   = "influxdb";
    rev    = "v${version}";
    sha256 = "0azj69an93nh81kk0zhn2fdilyn9dyrf6ag857sdiq2nk34z9zh8";
  };

  goDeps        =  ./deps.nix;
  goPackagePath = "github.com/influxdata/influxdb";

  excludedPackages = "test";

  patchPhase = ''
    sed -i -e 's/version = "unknown"/version = "${version}"/g' ./cmd/influxd/main.go
  '';
}
