{ stdenv, buildPerlPackage, fetchurl, perlPackages }:

# nix-generate-from-cpan
buildPerlPackage rec {
  name = "Test-Nginx-0.26";
  src = fetchurl {
    url = "mirror://cpan/authors/id/A/AG/AGENT/${name}.tar.gz";
    sha256 = "7ee10fb976c77a363b3af743c5eb8dd82cc2be726dfffe09066e2034199c6969";
  };

  propagatedBuildInputs = with perlPackages; [
    HTTPMessage LWP ListMoreUtils TestBase TestLongString TextDiff URI
  ];

  meta = {
    description = "Data-driven test scaffold for Nginx C module and Nginx/OpenResty-based libraries and applications";
    license = stdenv.lib.licenses.bsd3;
  };
}
