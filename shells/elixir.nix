with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "nix-shell-elixir";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[${name}:\w]$ "
  '';

  buildInputs = [
    elixir
  ];
}
