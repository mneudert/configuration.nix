{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "mmdbinspect-${version}";
  version = "git.2024-09-13";
  vendorHash = "sha256-MuTZmuVXerzo2+NgMHvMPysvWo90M7iNbBs5npj+KTw=";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbinspect";
    rev = "90021b0d1a49af213c21bd50c6321da39610919f";
    hash = "sha256-7muOd5xHrHyIpxAHRZEc1RSzsn6P7RTyh8JBfOpw3fw=";
  };

  doCheck = false;
}
