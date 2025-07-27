with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "generic-shell-nginx";

  shellHook = ''
    export LUA_CPATH="${lua51Packages.cjson}/lib/lua/5.1/?.so;${lua51Packages.cjson}/share/lua/5.1/?.so"
    export PS1="[generic:nginx|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  nginx = pkgs.nginx.override { modules = [ pkgs.nginxModules.lua ]; };

  perl_TestNginx =
    pkgs.callPackage /data/projects/private/configuration.nix/packages/perl/TestNginx
      { };

  buildInputs = [
    nginx

    lua51Packages.cjson

    perl
    perl_TestNginx
  ];
}
