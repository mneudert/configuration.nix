with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "project-shell-phoenix";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export ERL_AFLAGS="-kernel shell_history enabled"
    export PS1="[${name}:\w]$ "
  '';

  elixir = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir { erlang = erlangR20; };

  buildInputs = [
    elixir
    erlangR20
    nodejs-6_x

    inotify-tools
  ];
}
