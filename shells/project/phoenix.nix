with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "project-shell-phoenix";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[${name}:\w]$ "
  '';

  elixir = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir {};

  buildInputs = [
    elixir
    nodejs-6_x

    inotify-tools
  ];
}
