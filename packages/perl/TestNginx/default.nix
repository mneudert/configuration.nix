{ stdenv, lib, fetchurl, perlPackages }:

# nix-generate-from-cpan
perlPackages.buildPerlPackage rec {
  pname = "Test-Nginx";
  version = "0.29";

  src = fetchurl {
    url = "mirror://cpan/authors/id/A/AG/AGENT/Test-Nginx-0.29.tar.gz";
    hash = "sha256-tyZo8Rm86Vk8aEKf3BrU9E8cPn+RTAJpNkU5lyh76Bc=";
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
    description =
      "Data-driven test scaffold for Nginx C module and Nginx/OpenResty-based libraries and applications";
    license = lib.licenses.bsd3;
  };
}
