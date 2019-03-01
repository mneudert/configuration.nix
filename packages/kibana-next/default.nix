{ stdenv, fetchurl, makeWrapper, pkgs }:

stdenv.mkDerivation rec {
  nodejs = pkgs.nodejs-10_x.overrideAttrs (oldAttrs: rec {
    name = "nodejs-${version}";
    version = "10.15.1";

    src = fetchurl {
      url = "https://nodejs.org/dist/v${version}/node-v${version}.tar.xz";
      sha256 = "0n68c4zjakdj6yzdc9fbrn0wghyslkya9sz1v6122i40zfwzfm8s";
    };
  });

  name    = "kibana-${version}";
  version = "7.0.0-beta1";

  src = fetchurl {
    url = "https://artifacts.elastic.co/downloads/kibana/kibana-oss-${version}-linux-x86_64.tar.gz";
    sha256 = "0b5awnpqj7mk5hzm5grs4iyjvbhkbf89ir35p01v9w3qa8b7fjmd";
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
