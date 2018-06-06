{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name    = "misspell-${version}";
  version = "0.3.4";

  src = fetchFromGitHub {
    owner  = "client9";
    repo   = "misspell";
    rev    = "v${version}";
    sha256 = "1vwf33wsc4la25zk9nylpbp9px3svlmldkm0bha4hp56jws4q9cs";
  };

  goDeps        = ./deps.nix;
  goPackagePath = "github.com/client9/misspell";
}
