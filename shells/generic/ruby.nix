with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "generic-shell-ruby";

  shellHook = ''
    export BUNDLE_PATH="$(pwd)/vendor"
    export PS1="[generic:ruby|\[\e[1m\]\w\[\e[0m\]]$ "
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
