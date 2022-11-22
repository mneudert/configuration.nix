{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "mmdbinspect-${version}";
  version = "git.2022-11-21";
  vendorSha256 = "sha256-D9DG7lvQQPGMb5v+oahPftP6afWXzNDCTS+GW6bT3VY=";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbinspect";
    rev = "cc745ee8d21c3211b534b7c493dee730c163c8f6";
    hash = "sha256-gIocgMinV27ilsxi1YwdzDXhAfWKyIYFtePIxOCZeBw=";
  };

  doCheck = false;
}
