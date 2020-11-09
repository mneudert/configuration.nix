{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "influxdb-${version}";
  version = "1.8.3";
  vendorSha256 = "1pylw30dg6ljxm9ykmsqapg1vq71bj1ngdq4arvmmzcdhy1nhmh0";

  src = fetchFromGitHub {
    owner = "influxdata";
    repo = "influxdb";
    rev = "v${version}";
    sha256 = "1siv31gp7ypjphxjfv91sxzpz2rxk1nn2aj17pgk0cz7c8m59ic7";
  };

  doCheck = false;

  patchPhase = ''
    sed -i -e 's/version = "unknown"/version = "${version}"/g' ./cmd/influxd/main.go
  '';
}
