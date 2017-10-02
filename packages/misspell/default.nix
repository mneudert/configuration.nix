{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name    = "misspell-${version}";
  version = "2017-06-21";

  src = fetchFromGitHub {
    owner  = "client9";
    repo   = "misspell";
    rev    = "e1f24e3e0b6b2c8bc98584370d382ae095b13c94";
    sha256 = "0flviqax4d27815bmhrj83zdd9m27dpk2mabqcwr7x6m2jijz077";
  };

  goDeps        = ./deps.nix;
  goPackagePath = "github.com/client9/misspell";
}
