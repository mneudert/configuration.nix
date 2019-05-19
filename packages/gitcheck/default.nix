{ fetchFromGitHub, pkgs }:

pkgs.python37Packages.buildPythonPackage rec {
  name = "gitcheck-${version}";
  version = "2019-05-19-fork";

  src = fetchFromGitHub {
    owner = "mneudert";
    repo = "gitcheck";
    rev = "a2a5f5105877e0e1f0dea860315c4af62d976dff";
    sha256 = "03b7vjcdqx26hamb7623xa8ybabnivsdmqz9nklddh99253msdqf";
  };

  doCheck = false;

  propagatedBuildInputs = with pkgs; [
    python37Packages.colored
    python37Packages.GitPython
  ];
}
