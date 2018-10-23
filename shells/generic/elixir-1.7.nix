with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-elixir-1.7";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export ERL_AFLAGS="-kernel shell_history enabled"
    export PS1="[generic:elixir-1.7|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  elixir = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir-1.7 { erlang = erlangR20; };

  buildInputs = [
    elixir
    erlangR20
  ];
}
