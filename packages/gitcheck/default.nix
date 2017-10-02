{ fetchFromGitHub, pkgs }:

pkgs.python27Packages.buildPythonPackage rec {
  name    = "gitcheck-${version}";
  version = "2016-11-21";

  src = fetchFromGitHub {
    owner  = "badele";
    repo   = "gitcheck";
    rev    = "48a7a2323c48bdbc00f35eafae9c14af83792fce";
    sha256 = "047ilh4hsig3lhmn4s97n35gzhklh2k69ryz4kjd2kccn604vdqa";
  };

  doCheck = false;

  propagatedBuildInputs = with pkgs; [
    python27Packages.python
    python27Packages.colored
  ];
}
