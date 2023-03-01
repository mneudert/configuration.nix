{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "mmdbinspect-${version}";
  version = "git.2023-02-27";
  vendorSha256 = "sha256-eFuOxuaHjCK4+b7QPKa0fcELDr5uSJltTtlo6lQrWhc=";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbinspect";
    rev = "ef1d63eb9ab3f5e58a5edcd4a33fb0fc50f15b08";
    hash = "sha256-vO87Sk5zhd+BhzxlQTivm3A0VlvWn9Hs4NxhYr2rYqQ=";
  };

  doCheck = false;
}
