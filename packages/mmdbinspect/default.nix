{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "mmdbinspect-${version}";
  version = "git.2024-11-24";
  vendorHash = "sha256-MuTZmuVXerzo2+NgMHvMPysvWo90M7iNbBs5npj+KTw=";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbinspect";
    rev = "5a63af43c14a9ad54507443c354438ebf2e24d84";
    hash = "sha256-CBHbELaj8u92DGyupUcRw/3vXYk4iKb/TOahIQrT6/Q=";
  };

  doCheck = false;
}
