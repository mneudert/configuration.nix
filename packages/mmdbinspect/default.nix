{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "mmdbinspect-${version}";
  version = "git.2023-12-13";
  vendorHash = "sha256-HNgofsfMsqXttnrNDIPgLHag+2hqQTREomcesWldpMo=";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbinspect";
    rev = "6101ed839d9d132498fed30b1c30866a7fad6e53";
    hash = "sha256-hrbwOMpVAMXVxmx643/RXUVUhs7nR5GLs/wJ/R1iPds=";
  };

  doCheck = false;
}
