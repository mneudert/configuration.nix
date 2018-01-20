with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-elixir";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export ERL_AFLAGS="-kernel shell_history enabled"
    export PS1="[${name}:\w]$ "
  '';

  rebar = pkgs.rebar.override { erlang = erlangR20; };

  elixir-legacy = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir-legacy {
    erlang = erlangR20;
    rebar  = rebar;
  };

  buildInputs = [
    elixir-legacy
    erlangR20
  ];
}
