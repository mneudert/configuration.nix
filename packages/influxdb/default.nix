{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "influxdb-${version}";
  version = "1.8.0";
  modSha256 = "058gg66bvxxk1nia9gqjvimvwvpcbl5xq0y5y58yyx2hv0l3xl0c";

  src = fetchFromGitHub {
    owner = "influxdata";
    repo = "influxdb";
    rev = "v${version}";
    sha256 = "111n36xifmd644xp80imqxx61nlap6fdwx1di2qphlqb43z99jrq";
  };

  patchPhase = ''
    sed -i -e 's/version = "unknown"/version = "${version}"/g' ./cmd/influxd/main.go
  '';
}
