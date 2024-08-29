{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "mmdbverify-${version}";
  version = "git.2024-07-01";
  vendorHash = "sha256-ccE2WQ9q/LjqgSuwBlT36EvDVzuMBwXfB+il5zLG0fQ=";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbverify";
    rev = "d18fe372f29f1b89601b8b83fa140001261f2a7d";
    hash = "sha256-HLyrC8Mx1uUqtWvlxYE8mE2vqv8vcwwPqpQ+v1MpYqY=";
  };

  doCheck = false;
}
