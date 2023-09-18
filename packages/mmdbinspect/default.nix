{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "mmdbinspect-${version}";
  version = "git.2023-09-06";
  vendorSha256 = "sha256-HNgofsfMsqXttnrNDIPgLHag+2hqQTREomcesWldpMo=";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbinspect";
    rev = "65317503b83f8eaa7b3753a7a35d574d69bc48c3";
    hash = "sha256-3hH+NzzUe25AbVHkJtklolHQA/9b8PLyhelabQ0OqTI=";
  };

  doCheck = false;
}
