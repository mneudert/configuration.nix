{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "influxdb-${version}";
  version = "1.8.10";
  vendorSha256 = "sha256-jgAbEWXL1LYRN7ud9ij0Z1KBGHPZ0sRq78tsK92ob8k=";

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
