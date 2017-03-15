with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-ruby";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[${name}:\w]$ "
  '';

  buildInputs = [
    libxml2
    zlib

    ruby
    bundler
  ];
}
