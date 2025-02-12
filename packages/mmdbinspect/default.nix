{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  name = "mmdbinspect-${version}";
  version = "git.2025-02-07";
  vendorHash = "sha256-QQoAbQwEqCprvq6/znH/apHuOGWVte40MwJwNURtZFQ=";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "mmdbinspect";
    rev = "5b297221230ea5bda27d2895c89c9db92568f385";
    hash = "sha256-JnAGI4zig/41mrCtOZbIsEydUwCPsIwL2/EqOHYoDQI=";
  };

  doCheck = false;
}
