{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "influxdb-${version}";
  version = "1.8.10";
  vendorSha256 = "1jbgm3fjnv6bxxmc9lnrfcc82lk7yhlgd7dv6w8vdm6bcl8in04f";

  src = fetchFromGitHub {
    owner = "influxdata";
    repo = "influxdb";
    rev = "v${version}";
    hash = "sha256-PErAxRpSi1Kk6IpEAhsUSxCGYeY4p6bbhwLdbRB0M00=";
  };

  doCheck = false;

  patchPhase = ''
    sed -i -e 's/version = "unknown"/version = "${version}"/g' ./cmd/influxd/main.go
  '';
}
