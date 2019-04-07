# requires "unar" to be already installed!
{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "ievms-${version}";
  version = "0.3.3";

  src = fetchFromGitHub {
    owner = "xdissent";
    repo = "ievms";
    rev = "ad487055333658a5b3555c6d1425e229a18b9409";
    sha256 = "02lrmmc21c29xhc89x4aqyhm604b8imbi05lax967drnirbawcbh";
  };

  patchPhase = "patchShebangs ./ievms.sh";
  buildPhase = "mkdir -p $out/bin";
  installPhase = "cp ./ievms.sh $out/bin/";
}
