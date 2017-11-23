{ fetchFromGitHub, pkgs }:

pkgs.python27Packages.buildPythonPackage rec {
  name    = "gitcheck-${version}";
  version = "2017-11-23-fork";

  src = fetchFromGitHub {
    owner  = "mneudert";
    repo   = "gitcheck";
    rev    = "6329e5423fa0a5ef72d6c5be566bbdb6eaa70de4";
    sha256 = "060abfilkbacn301wjwsbcbs98zzd18nb7dzdmfybwdz2ppb6a32";
  };

  doCheck = false;

  propagatedBuildInputs = with pkgs; [
    python27Packages.python
    python27Packages.colored
  ];
}
