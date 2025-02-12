{
  stdenv,
  lib,
  fetchurl,
  perlPackages,
}:

# nix-generate-from-cpan
perlPackages.buildPerlPackage rec {
  pname = "Test-Nginx";
  version = "0.30";

  src = fetchurl {
    url = "mirror://cpan/authors/id/A/AG/AGENT/Test-Nginx-${version}.tar.gz";
    hash = "sha256-gJdYU1HsIOLANWByNv54tSeevmJDXh/7kokV0m6xJrI=";
  };

  propagatedBuildInputs = with perlPackages; [
    HTTPMessage
    IPCRun
    LWP
    ListMoreUtils
    TestBase
    TestLongString
    TextDiff
    URI
  ];

  meta = {
    description = "Data-driven test scaffold for Nginx C module and Nginx/OpenResty-based libraries and applications";
    license = lib.licenses.bsd3;
  };
}
