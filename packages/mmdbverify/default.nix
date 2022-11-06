{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "mmdbverify-${version}";
  version = "git.2022-08-30";
  vendorSha256 = "sha256-spwlkP4Qsz7+GeX9Ol1fLRcotLVuH33ufoYjo3q7Nsw=";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbverify";
    rev = "5072d9405ca81cb4d13eb484a9277b7056ede3ae";
    hash = "sha256-KWY/ft74QCmFrA8edBEyApVfYkiimREoWrrSDY1kc8Q=";
  };

  doCheck = false;
}
