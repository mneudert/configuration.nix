{ fetchFromGitHub, pkgs }:

pkgs.python3Packages.buildPythonPackage rec {
  name = "gitcheck-${version}";
  version = "2019-05-19-fork";

  src = fetchFromGitHub {
    owner = "mneudert";
    repo = "gitcheck";
    rev = "a2a5f5105877e0e1f0dea860315c4af62d976dff";
    hash = "sha256-DjddRxEpwdbotOnj2vSOdqnlkepDmLOqgkZ03JjcZw0=";
  };

  doCheck = false;

  propagatedBuildInputs = with pkgs; [
    python3Packages.colored
    python3Packages.GitPython
  ];
}
