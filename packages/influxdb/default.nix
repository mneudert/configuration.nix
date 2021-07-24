{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "influxdb-${version}";
  version = "1.8.7";
  vendorSha256 = "1jbgm3fjnv6bxxmc9lnrfcc82lk7yhlgd7dv6w8vdm6bcl8in04f";

  src = fetchFromGitHub {
    owner = "influxdata";
    repo = "influxdb";
    rev = "v${version}";
    sha256 = "0h1kibs9hgql91y1dx97m71l6nfjy1rf9955ddi4gicsgfxin0r0";
  };

  doCheck = false;

  patchPhase = ''
    sed -i -e 's/version = "unknown"/version = "${version}"/g' ./cmd/influxd/main.go
  '';
}
