{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name    = "influxdb-${version}";
  version = "1.5.3";

  src = fetchFromGitHub {
    owner  = "influxdata";
    repo   = "influxdb";
    rev    = "v${version}";
    sha256 = "1ma1fcqmy3j2lk3cmb61i3xsw9ag2ffwzlqw77cxhhws3m9v2vhj";
  };

  goDeps        =  ./deps.nix;
  goPackagePath = "github.com/influxdata/influxdb";

  excludedPackages = "test";

  patchPhase = ''
    sed -i -e 's/version = "unknown"/version = "${version}"/g' ./cmd/influxd/main.go
  '';
}
