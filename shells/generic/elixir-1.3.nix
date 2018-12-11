with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-elixir-1.3";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export ERL_AFLAGS="-kernel shell_history enabled"
    export HEX_HOME="$HOME/.nix-shells-data/${name}/.hex"
    export MIX_HOME="$HOME/.nix-shells-data/${name}/.mix"
    export PS1="[generic:elixir-1.3|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  rebar = pkgs.rebar.override { erlang = erlangR20; };

  elixir = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir-1.3 {
    erlang = erlangR20;
    rebar  = rebar;
  };

  buildInputs = [
    elixir
    erlangR20
  ];
}
