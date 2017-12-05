{ fetchFromGitHub, pkgs }:

pkgs.python27Packages.buildPythonPackage rec {
  name    = "gitcheck-${version}";
  version = "2017-12-05-fork";

  src = fetchFromGitHub {
    owner  = "mneudert";
    repo   = "gitcheck";
    rev    = "fbfef71ddadb09c358bddbe28287b7fd27528cb0";
    sha256 = "0ny0nham7zx76ark2451dvyhivj7v7n3qaypyzdrq75wjp884ljn";
  };

  doCheck = false;

  propagatedBuildInputs = with pkgs; [
    python27Packages.python
    python27Packages.colored
  ];
}
