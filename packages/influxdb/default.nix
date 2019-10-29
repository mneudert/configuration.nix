{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name = "influxdb-${version}";
  version = "1.7.9";

  src = fetchFromGitHub {
    owner = "influxdata";
    repo = "influxdb";
    rev = "v${version}";
    sha256 = "021a00glzqmv3pszsj17gd9v1kzfmxzahh5s9hsq72kvaby8a3bh";
  };

  goDeps =  ./deps.nix;
  goPackagePath = "github.com/influxdata/influxdb";

  excludedPackages = "test";

  patchPhase = ''
    sed -i -e 's/version = "unknown"/version = "${version}"/g' ./cmd/influxd/main.go
  '';
}
