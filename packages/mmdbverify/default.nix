{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "mmdbverify-${version}";
  version = "git.2024-06-05";
  vendorHash = "sha256-bsTBOGrm0hPSWxky9pkkFDTlRaPVBJjlUc2DKdH0fUM=";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbverify";
    rev = "68e2b5bd3b2866d610a2bef42674ed4e86f1984b";
    hash = "sha256-NZOAcrxPbH3b553EQ6nEJCaUF9IOKCzaJVV92UDRTTU=";
  };

  doCheck = false;
}
