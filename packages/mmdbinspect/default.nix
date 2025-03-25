{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  name = "mmdbinspect-${version}";
  version = "git.2025-03-21";
  vendorHash = "sha256-xgNGwIjUJ+bwqTzpi/dCdNlMbTRp4VU49cz+jY+90Ec=";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbinspect";
    rev = "212016765c7a000ca0fbc0f53e8bd7d47d9d615b";
    hash = "sha256-MYNuWm5hEspIsWFw3Ktg05jzuDlbdFCCufX0hfEkmws=";
  };

  doCheck = false;
}
