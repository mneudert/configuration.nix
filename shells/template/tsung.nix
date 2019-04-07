with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "template-shell-tsung";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[template:tsung|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  tsung = pkgs.callPackage /data/projects/private/configuration.nix/packages/tsung {};

  buildInputs = [
    tsung
  ];
}
