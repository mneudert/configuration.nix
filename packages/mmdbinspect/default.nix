{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "mmdbinspect-${version}";
  version = "git.2023-12-05";
  vendorHash = "sha256-HNgofsfMsqXttnrNDIPgLHag+2hqQTREomcesWldpMo=";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbinspect";
    rev = "26869cce2eb34e6e6cad9c0091378d7ce07ca843";
    hash = "sha256-J65UZ+D97Q862IVUmA6VqfMeLLVEpzhJtd6EBanO0gk=";
  };

  doCheck = false;
}
