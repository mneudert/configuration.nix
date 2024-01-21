{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "mmdbinspect-${version}";
  version = "0.2.0";

  src = fetchurl {
    url =
      "https://github.com/maxmind/mmdbinspect/releases/download/v${version}/mmdbinspect_${version}_linux_amd64.tar.gz";
    sha256 = "sha256-hXdIctmUUJsJ1qyXmpuDMVnOeXDoQoMqpRCo0j1fFXc=l";
  };

  installPhase = ''
    mkdir -p $out/bin/
    cp -R mmdbinspect $out/bin/
  '';
}
