{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "influxdb-${version}";
  version = "1.8.4";
  vendorSha256 = "1qj6yszl7v3fx7za4x30pm7zik7z0irfjz1dxaa3f4922j98905z";

  src = fetchFromGitHub {
    owner = "influxdata";
    repo = "influxdb";
    rev = "v${version}";
    sha256 = "02lz27cyfcichidxw2rnm82gqwj64125xcgzx0fmc4lc85lr1gvh";
  };

  doCheck = false;

  patchPhase = ''
    sed -i -e 's/version = "unknown"/version = "${version}"/g' ./cmd/influxd/main.go
  '';
}
