{ pkgs, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "hidrd-convert-${version}";
  version = "dev-2017-08-02";

  src = fetchFromGitHub {
    owner = "DIGImend";
    repo = "hidrd";
    rev = "7e94881a6059a824efaed41301c4a89a384d86a2";
    hash = "sha256-d5tIz+07XkXxEorLtmaaZWZcIxsI1jx1JGpQTp/Ar+Q=";
  };

  preConfigure = ''
    patchShebangs ./bootstrap
    ./bootstrap

    sed -i 's|/usr/bin/file|${pkgs.file}/bin/file|' ./configure
  '';

  buildInputs = with pkgs; [ autoconf automake libtool ];
}
