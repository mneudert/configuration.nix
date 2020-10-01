{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "influxdb-${version}";
  version = "1.8.3";
  modSha256 = "0ysa22azqbc70six0n8zz2q9hwrl81x5wjbh9akcnk8025idpbhy";

  src = fetchFromGitHub {
    owner = "influxdata";
    repo = "influxdb";
    rev = "v${version}";
    sha256 = "1siv31gp7ypjphxjfv91sxzpz2rxk1nn2aj17pgk0cz7c8m59ic7";
  };

  patchPhase = ''
    sed -i -e 's/version = "unknown"/version = "${version}"/g' ./cmd/influxd/main.go
  '';
}
