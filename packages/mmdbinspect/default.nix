{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "mmdbinspect-${version}";
  version = "git.2023-04-17";
  vendorSha256 = "sha256-eFuOxuaHjCK4+b7QPKa0fcELDr5uSJltTtlo6lQrWhc=";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbinspect";
    rev = "c32eab778c47e05fdb82cc7eeac0e4019953a573";
    hash = "sha256-9DEwI9y3oMia+ZFePrJ/gSZJeyWrptp85Q+4G2TEJ1E=";
  };

  doCheck = false;
}
