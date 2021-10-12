{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "influxdb-${version}";
  version = "1.8.10";
  vendorSha256 = "1jbgm3fjnv6bxxmc9lnrfcc82lk7yhlgd7dv6w8vdm6bcl8in04f";

  src = fetchFromGitHub {
    owner = "influxdata";
    repo = "influxdb";
    rev = "v${version}";
    sha256 = "0k9kfh86vp82hzdsd9rqwrhqc42b2hdh4i4ax2j552sj3b2w0jiw";
  };

  doCheck = false;

  patchPhase = ''
    sed -i -e 's/version = "unknown"/version = "${version}"/g' ./cmd/influxd/main.go
  '';
}
