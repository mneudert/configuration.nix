{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name    = "influxdb-${version}";
  version = "1.6.4";

  src = fetchFromGitHub {
    owner  = "influxdata";
    repo   = "influxdb";
    rev    = "v${version}";
    sha256 = "1i7qw76crv5cysd5mzigsrji66xlyvwzc3bvcfv9y2d7cy4af8s1";
  };

  goDeps        =  ./deps.nix;
  goPackagePath = "github.com/influxdata/influxdb";

  excludedPackages = "test";

  patchPhase = ''
    sed -i -e 's/version = "unknown"/version = "${version}"/g' ./cmd/influxd/main.go
  '';
}
