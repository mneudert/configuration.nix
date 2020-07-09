{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "influxdb-${version}";
  version = "1.8.1";
  modSha256 = "07v4ijblvl2zq049fdz5vdfhk6d3phrsajhnhwl46x02dbdzgj13";

  src = fetchFromGitHub {
    owner = "influxdata";
    repo = "influxdb";
    rev = "v${version}";
    sha256 = "0baf1rdr8zv8ss6i05753ga2qfs549majamz1a91vza42z5ibjhs";
  };

  patchPhase = ''
    sed -i -e 's/version = "unknown"/version = "${version}"/g' ./cmd/influxd/main.go
  '';
}
