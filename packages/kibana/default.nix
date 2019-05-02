{ stdenv, fetchurl, makeWrapper, pkgs }:

stdenv.mkDerivation rec {
  nodejs = pkgs.nodejs-10_x.overrideAttrs (oldAttrs: rec {
    name = "nodejs-${version}";
    version = "10.15.2";

    src = fetchurl {
      url = "https://nodejs.org/dist/v${version}/node-v${version}.tar.xz";
      sha256 = "0ncc27azpfrhc55n4j35wqcxbf7n42j0j07pq9dqjvh1rfkjvfxq";
    };
  });

  name = "kibana-${version}";
  version = "7.0.1";

  src = fetchurl {
    url = "https://artifacts.elastic.co/downloads/kibana/kibana-oss-${version}-linux-x86_64.tar.gz";
    sha256 = "1x3gjc9xa03m4jfnl5vjxigzcnb8ysnhxgd8618v85x4l0010v38";
  };

  buildInputs = [ makeWrapper nodejs ];

  installPhase = ''
    mkdir -p $out/libexec/kibana $out/bin
    mv * $out/libexec/kibana/
    rm -r $out/libexec/kibana/node

    makeWrapper $out/libexec/kibana/bin/kibana $out/bin/kibana \
      --prefix PATH : "${stdenv.lib.makeBinPath [ nodejs ]}"

    sed -i 's@NODE=.*@NODE=${nodejs}/bin/node@' $out/libexec/kibana/bin/kibana
  '';
}
