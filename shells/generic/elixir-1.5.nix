with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-elixir-1.5";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export ERL_AFLAGS="-kernel shell_history enabled"
    export PS1="[generic:elixir-1.5|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  rebar = pkgs.rebar.override { erlang = erlangR20; };

  elixir = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir-1.5 {
    erlang = erlangR20;
    rebar  = rebar;
  };

  buildInputs = [
    elixir
    erlangR20
  ];
}
