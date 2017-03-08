with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "nix-shell-php-7.0";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[${name}:\w]$ "
  '';

  buildInputs = [
    php70
  ];
}
