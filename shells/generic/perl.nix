with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-perl";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[generic:perl|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = [
    perl
    perlPackages.PerlCritic

    nix-generate-from-cpan
  ];
}
