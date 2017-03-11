{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name    = "bash-todo";
  version = "eecd25a";

  src = fetchFromGitHub {
    owner  = "mneudert";
    repo   = "${name}";
    rev    = "eecd25abdda7a5eaf9105a1d793ab5618fd0a781";
    sha256 = "1wkiqxy5h9qk9sf1sl2nnf8fdz504p75v00z6bgcmh85y03wf01x";
  };

  patchPhase   = "patchShebangs ./todo";
  buildPhase   = "mkdir -p $out/bin";
  installPhase = "cp ./todo $out/bin/";
}
