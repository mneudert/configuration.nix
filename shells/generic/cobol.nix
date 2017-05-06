with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-cobol";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[${name}:\w]$ "
  '';

  gnu-cobol = pkgs.callPackage /data/projects/private/configuration.nix/packages/gnu-cobol {};

  buildInputs = [
    gnu-cobol
  ];
}
