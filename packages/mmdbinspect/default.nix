{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "mmdbinspect-${version}";
  version = "git.2024-08-14";
  vendorHash = "sha256-MuTZmuVXerzo2+NgMHvMPysvWo90M7iNbBs5npj+KTw=";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbinspect";
    rev = "75fb13e176b40d84e867049dc45d0ba1fb251c07";
    hash = "sha256-0EuU0LO2qE2HUFMyxmu3C7HG4n3j++ims4Zgl/5CxY8=";
  };

  doCheck = false;
}
