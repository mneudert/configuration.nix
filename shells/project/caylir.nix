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
      --ignoredup \
      --logtostderr \
    2>/dev/null &

    function finish {
      ps | grep 'cayley' | grep -v 'grep' | awk '{ print $1 }' | xargs kill
    }

    trap finish EXIT

    export PS1="[${name}:\w]$ "
  '';

  cayley = pkgs.callPackage /data/projects/private/configuration.nix/packages/cayley {};
  elixir = pkgs.callPackage /data/projects/private/configuration.nix/packages/elixir {};

  buildInputs = [
    cayley
    elixir
  ];
}
