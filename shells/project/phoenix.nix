with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "project-shell-phoenix";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export ERL_AFLAGS="-kernel shell_history enabled"
    export PS1="[project:phoenix|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  elixir = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir-1.7 { erlang = erlangR20; };

  buildInputs = [
    elixir
    erlangR20
    nodejs

    inotify-tools
  ];
}
