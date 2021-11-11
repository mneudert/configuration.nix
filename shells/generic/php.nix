with import <nixpkgs> { };

let
  php = pkgs.php.withExtensions ({ enabled, all }: enabled ++ [ all.xdebug ]);
in
stdenv.mkDerivation rec {
  name = "generic-shell-php";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[generic:php|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = [ php phpPackages.composer ];
}
