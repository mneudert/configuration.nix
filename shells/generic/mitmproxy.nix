with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "generic-shell-mitmproxy";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[generic:mitmproxy|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  buildInputs = [ mitmproxy ];
}
