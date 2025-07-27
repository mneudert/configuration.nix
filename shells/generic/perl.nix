with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "generic-shell-perl";

  shellHook = ''
    export PS1="[generic:perl|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = [
    perl
    perlPackages.PerlCritic

    nix-generate-from-cpan
  ];
}
