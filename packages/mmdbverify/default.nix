{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "mmdbverify-${version}";
  version = "git.2025-02-07";
  vendorHash = "sha256-6wiE9/NxGI6sVnyWhCPfol0hsE3xgxCIz2PFvPd5iRc=";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbverify";
    rev = "546e17001c74548d0de5d3086096839fb92512fc";
    hash = "sha256-QCWqUAw63COD6YwA6hPXyRUv0rVa4GI6WLeQGP5Hez0=";
  };

  doCheck = false;
}
