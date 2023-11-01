{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "mmdbinspect-${version}";
  version = "git.2023-10-30";
  vendorSha256 = "sha256-HNgofsfMsqXttnrNDIPgLHag+2hqQTREomcesWldpMo=";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbinspect";
    rev = "798a08df83485d847710729375a4ea703fe170e6";
    hash = "sha256-W5w6p5pzbOKdnnmLbMoUaKeL7Y7WDoFnRgfC2gra0nA=";
  };

  doCheck = false;
}
