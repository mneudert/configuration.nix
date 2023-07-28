{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "mmdbverify-${version}";
  version = "git.2023-06-05";
  vendorSha256 = "sha256-spwlkP4Qsz7+GeX9Ol1fLRcotLVuH33ufoYjo3q7Nsw=";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbverify";
    rev = "ec44da3dce773564f3840e99353e038e10fcc7ff";
    hash = "sha256-h6nFAnaywWJJkppRp4zjgvSl/3pBGgu3DjZT65J2Q+I=";
  };

  doCheck = false;
}
