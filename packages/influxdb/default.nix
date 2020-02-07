{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name = "influxdb-${version}";
  version = "1.7.10";

  src = fetchFromGitHub {
    owner = "influxdata";
    repo = "influxdb";
    rev = "v${version}";
    sha256 = "0139h9ygilg4r3b9qdqbxdrn9fw163ghm63hfbh6p8z3aymd346f";
  };

  goDeps =  ./deps.nix;
  goPackagePath = "github.com/influxdata/influxdb";

  excludedPackages = "test";

  patchPhase = ''
    sed -i -e 's/version = "unknown"/version = "${version}"/g' ./cmd/influxd/main.go
  '';
}
