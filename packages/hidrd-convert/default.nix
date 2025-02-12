{
  pkgs,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  name = "hidrd-convert-${version}";
  version = "dev-2019-06-03";

  src = fetchFromGitHub {
    owner = "DIGImend";
    repo = "hidrd";
    rev = "6c0ed39708a5777ac620f902f39c8a0e03eefe4e";
    hash = "sha256-JK1llvWN8Vzu2YDf/wZJ41F81/034/Big7dmC5bB0OY=";
  };

  preConfigure = ''
    patchShebangs ./bootstrap
    ./bootstrap

    sed -i 's|/usr/bin/file|${pkgs.file}/bin/file|' ./configure
  '';

  buildInputs = with pkgs; [
    autoconf
    automake
    libtool
  ];
}
