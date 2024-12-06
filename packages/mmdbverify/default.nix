{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "mmdbverify-${version}";
  version = "git.2024-11-24";
  vendorHash = "sha256-ccE2WQ9q/LjqgSuwBlT36EvDVzuMBwXfB+il5zLG0fQ=";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbverify";
    rev = "e7a3898f4fb07b2bf381a3d8981bcc8459238e26";
    hash = "sha256-0obn4f8EapldatsL/HRgUjkiaf1W7MiGFH4zAjPtCTk=";
  };

  doCheck = false;
}
