{ stdenv, lib, buildPerlPackage, fetchurl, perlPackages }:

# nix-generate-from-cpan
buildPerlPackage rec {
  pname = "Test-Nginx";
  version = "0.29";

  src = fetchurl {
    url = "mirror://cpan/authors/id/A/AG/AGENT/Test-Nginx-0.29.tar.gz";
    sha256 = "b72668f119bce9593c68429fdc1ad4f44f1c3e7f914c026936453997287be817";
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
