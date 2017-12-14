{ fetchFromGitHub, pkgs }:

pkgs.python27Packages.buildPythonPackage rec {
  name    = "gitcheck-${version}";
  version = "2017-12-14-fork";

  src = fetchFromGitHub {
    owner  = "mneudert";
    repo   = "gitcheck";
    rev    = "02f42fc8df3d1db3f0a8e26c84556221dde32ca3";
    sha256 = "0xy9grz3xwj9lzivqvwkniqq00bzz6c0h4rqgpyssj139yvw09dn";
  };

  doCheck = false;

  propagatedBuildInputs = with pkgs; [
    python27Packages.python
    python27Packages.colored
  ];
}
