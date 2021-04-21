{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "influxdb-${version}";
  version = "1.8.5";
  vendorSha256 = "16lbxzn2jbwqdc6axpzxy1gckq520bdw389k8qfvdq65rapb1fxp";

  src = fetchFromGitHub {
    owner = "influxdata";
    repo = "influxdb";
    rev = "v${version}";
    sha256 = "0n3yr84lf75af7zs6ld98w0sarihb1981h6chj4klyllqi705ad8";
  };

  doCheck = false;

  patchPhase = ''
    sed -i -e 's/version = "unknown"/version = "${version}"/g' ./cmd/influxd/main.go
  '';
}
