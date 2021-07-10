with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "project-shell-vagrant";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    export BUNDLE_PATH="$(pwd)/vendor"
    export VAGRANT_HOME="$(pwd)/.vagrant.d"
    export PS1="[project:vagrant|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = [
    autoconf
    automake
    libtool
    libxml2
    zlib

    ruby
  ];
}
