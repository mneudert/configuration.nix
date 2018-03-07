{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name    = "influxdb-${version}";
  version = "1.5.0";

  src = fetchFromGitHub {
    owner  = "influxdata";
    repo   = "influxdb";
    rev    = "v${version}";
    sha256 = "1kqwcm4a4hsk329i8wzyybs0vi6m0s86lbhvfrgr9lbxc571z03f";
  };

  goDeps        =  ./deps.nix;
  goPackagePath = "github.com/influxdata/influxdb";

  excludedPackages = "test";

  patchPhase = ''
    sed -i -e 's/version = "unknown"/version = "${version}"/g' ./cmd/influxd/main.go
  '';
}
