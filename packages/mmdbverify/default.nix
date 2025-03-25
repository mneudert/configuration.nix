{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  name = "mmdbverify-${version}";
  version = "git.2025-03-21";
  vendorHash = "sha256-irjsOFzxBNMn0QrZOtxx68WfC+LOCtn0GWC30nT3Gvo=";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbverify";
    rev = "119c9062d10e8edfd2189919cee9f97dfac33de2";
    hash = "sha256-tgfpB2Af8x2hlIE3Xfokh/zkF/fHMmV1WuoBmnNuNCc=";
  };

  doCheck = false;
}
