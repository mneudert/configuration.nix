{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "mmdbinspect-${version}";
  version = "git.2024-06-05";
  vendorHash = "sha256-c/YRssKIme7BO4slDLCSfa8ap4f6qSfW2eDaH1xaD0I=";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbinspect";
    rev = "8769f5e9951a0b932c99cf4034fe248add51171c";
    hash = "sha256-Own/wpcZ4O0S8yb99I5zuGZ1sdxlsD0VAIoTgRwSy5A=";
  };

  doCheck = false;
}
