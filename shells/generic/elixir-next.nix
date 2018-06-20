with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-elixir-next";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export ERL_AFLAGS="-kernel shell_history enabled"
    export PS1="[${name}:\w]$ "
  '';

  elixir-next = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir-next {
    erlang = erlangR20;
  };

  buildInputs = [
    elixir-next
    erlangR20
  ];
}
