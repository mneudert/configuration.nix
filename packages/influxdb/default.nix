{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "influxdb-${version}";
  version = "1.8.9";
  vendorSha256 = "1jbgm3fjnv6bxxmc9lnrfcc82lk7yhlgd7dv6w8vdm6bcl8in04f";

  src = fetchFromGitHub {
    owner = "influxdata";
    repo = "influxdb";
    rev = "v${version}";
    sha256 = "1nfmvbam87m3g3wnhqsxj0y1ialy50rgfk67b65vpfs4ajfwxard";
  };

  doCheck = false;

  patchPhase = ''
    sed -i -e 's/version = "unknown"/version = "${version}"/g' ./cmd/influxd/main.go
  '';
}
