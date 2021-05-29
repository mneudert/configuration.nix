{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "influxdb-${version}";
  version = "1.8.6";
  vendorSha256 = "16lbxzn2jbwqdc6axpzxy1gckq520bdw389k8qfvdq65rapb1fxp";

  src = fetchFromGitHub {
    owner = "influxdata";
    repo = "influxdb";
    rev = "v${version}";
    sha256 = "18436i9ixpjlbqqlpgxxm6ahbnwlzkd51hfn487fam8kxjp1v7xz";
  };

  doCheck = false;

  patchPhase = ''
    sed -i -e 's/version = "unknown"/version = "${version}"/g' ./cmd/influxd/main.go
  '';
}
