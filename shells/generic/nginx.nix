with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "generic-shell-nginx";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export LUA_CPATH="${lua51Packages.cjson}/lib/lua/5.1/?.so;${lua51Packages.cjson}/share/lua/5.1/?.so"
    export PS1="[${name}:\w]$ "
  '';

  nginx = pkgs.nginx.override {
    modules = [ pkgs.nginxModules.lua ];
  };

  perl_TestNginx = pkgs.callPackage ../../packages/perl/TestNginx {};

  buildInputs = [
    nginx

    lua51Packages.cjson

    perl
    perl_TestNginx
  ];
}
