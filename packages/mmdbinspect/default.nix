{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "mmdbinspect-${version}";
  version = "git.2022-03-17";
  vendorSha256 = "0vpvjvh7mch68l7ix869pwywhv30l73jk9igdilzsh8c4nj2m70c";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbinspect";
    rev = "036d46dd77ea88b9d1c1449a7dc8012d6ea6a27c";
    hash = "sha256-RGDmR4BcSrQb3IcegNIM/ghdsedITTaldbkpwMiw7Cs=";
  };

  doCheck = false;
}
