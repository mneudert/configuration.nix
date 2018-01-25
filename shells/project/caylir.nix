with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "project-shell-caylir";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    cayley http \
      --db=memstore --dbpath="" \
    2>/dev/null &

    function finish {
      ps | grep 'cayley' | grep -v 'grep' | awk '{ print $1 }' | xargs kill
    }

    trap finish EXIT

    export ERL_AFLAGS="-kernel shell_history enabled"
    export PS1="[${name}:\w]$ "
  '';

  rebar = pkgs.rebar.override { erlang = erlangR20; };

  cayley = pkgs.callPackage /data/projects/private/configuration.nix/packages/cayley {};
  elixir = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir {
    erlang = erlangR20;
    rebar  = rebar;
  };

  buildInputs = [
    cayley
    elixir
  ];
}
