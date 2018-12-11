with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-elixir-1.7";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export ERL_AFLAGS="-kernel shell_history enabled"
    export HEX_HOME="$HOME/.nix-shells-data/${name}/.hex"
    export MIX_HOME="$HOME/.nix-shells-data/${name}/.mix"
    export PS1="[generic:elixir-1.7|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  elixir = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir-1.7 { erlang = erlangR20; };

  buildInputs = [
    elixir
    erlangR20
  ];
}
