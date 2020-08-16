{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "influxdb-${version}";
  version = "1.8.2";
  modSha256 = "07v4ijblvl2zq049fdz5vdfhk6d3phrsajhnhwl46x02dbdzgj13";

  src = fetchFromGitHub {
    owner = "influxdata";
    repo = "influxdb";
    rev = "v${version}";
    sha256 = "11zkia43i3in1xv84iz6rm9cfhf4k6nxn144m7dz7a7nv3chi20g";
  };

  patchPhase = ''
    sed -i -e 's/version = "unknown"/version = "${version}"/g' ./cmd/influxd/main.go
  '';
}
