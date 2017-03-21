with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "project-shell-caylir";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    cayley http --db=memstore --dbpath='' &

    function finish {
      ps | grep 'cayley' | grep -v 'grep' | awk '{ print $1 }' | xargs kill
    }

    trap finish EXIT

    export PS1="[${name}:\w]$ "
  '';

  cayley = pkgs.callPackage /data/projects/private/configuration.nix/packages/cayley {};

  buildInputs = [
    cayley
    elixir
  ];
}
