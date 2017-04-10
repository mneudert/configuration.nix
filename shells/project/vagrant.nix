with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "project-shell-vagrant";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[${name}:\w]$ "
    export VAGRANT_HOME="$(pwd)/.vagrant.d"
  '';

  buildInputs = [
    libxml2
    zlib

    ruby
    bundler
  ];
}
