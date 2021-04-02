{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "bash-todo-${version}";
  version = "2021-02-24";

  src = fetchFromGitHub {
    owner = "mneudert";
    repo = "bash-todo";
    rev = "12fa02d906f6d311b79fa32ec6665de9791087b4";
    sha256 = "17avnyywqlxw5aw45cbspcl6vpnnjdxy4ri627w3a6k5rwf855x2";
  };

  patchPhase = "patchShebangs ./todo";
  buildPhase = "mkdir -p $out/bin";
  installPhase = "cp ./todo $out/bin/";
}
