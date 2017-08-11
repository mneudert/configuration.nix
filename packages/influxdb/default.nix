{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name    = "influxdb-${version}";
  version = "1.3.3";

  src = fetchFromGitHub {
    owner  = "influxdata";
    repo   = "influxdb";
    rev    = "v${version}";
    sha256 = "146dagbdnwj9spqjmf0lzlir0x7ks9p07rr7c37rfdnf0ar7j6b3";
  };

  goDeps        =  ./deps.nix;
  goPackagePath = "github.com/influxdata/influxdb";

  excludedPackages = "test";

  patchPhase = ''
    sed -i -e 's/version = "unknown"/version = "${version}"/g' ./cmd/influxd/main.go
  '';
}
