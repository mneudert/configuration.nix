{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name    = "bash-todo";
  version = "435c77c";

  src = fetchFromGitHub {
    owner  = "mneudert";
    repo   = "${name}";
    rev    = "435c77c928b94bab36c5e4f51b9314579d7f3a20";
    sha256 = "08alk3wnv03md8pfxiwdzz40pdz5dfmaklxbdnq67h4hmfixa2rm";
  };

  patchPhase   = "patchShebangs ./todo";
  buildPhase   = "mkdir -p $out/bin";
  installPhase = "cp ./todo $out/bin/";
}
