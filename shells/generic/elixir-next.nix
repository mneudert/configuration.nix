with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-elixir-next";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export ERL_AFLAGS="-kernel shell_history enabled"
    export PS1="[generic:elixir-next|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  elixir = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir-next { erlang = erlangR20; };

  buildInputs = [
    elixir
    erlangR20
  ];
}
