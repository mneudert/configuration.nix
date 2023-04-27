{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "mmdbverify-${version}";
  version = "git.2023-03-16";
  vendorSha256 = "sha256-spwlkP4Qsz7+GeX9Ol1fLRcotLVuH33ufoYjo3q7Nsw=";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbverify";
    rev = "a5191b352a686533f1d64c29d9ecb0923b5df593";
    hash = "sha256-wsqHrNptYB/RqQthI6aCQ2Pa/79uzYuIQG782vs4vHs=";
  };

  doCheck = false;
}
