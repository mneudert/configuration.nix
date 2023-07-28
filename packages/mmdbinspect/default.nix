{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "mmdbinspect-${version}";
  version = "git.2023-06-05";
  vendorSha256 = "sha256-tSY4nlRrjE0cLzAY8LW6PmcZnaCbhFES4Wjju4/qMyw=";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbinspect";
    rev = "c1996c2cadaaa1eb249a08b459177583ed8cba9c";
    hash = "sha256-pVo9I7WxTzF+7rRvn1LVe3w1/LnOGt+//1lZ9K4LWC0=";
  };

  doCheck = false;
}
