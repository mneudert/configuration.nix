{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "mmdbinspect-${version}";
  version = "git.2022-06-30";
  vendorSha256 = "sha256-zU0g3AsqLjdxBoT5Ii4ds/UY5j4emHgivCykOu9gCRw=";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbinspect";
    rev = "8464132679c173b6ffe2728847cdcd03c62c9b59";
    hash = "sha256-vY3eTq7GqDw4QArdre0/90TdH7sb1QJYobWHU2g54hI=";
  };

  doCheck = false;
}
