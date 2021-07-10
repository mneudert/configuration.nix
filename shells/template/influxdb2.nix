with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "template-shell-influxdb2";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    SHELL_NAME="template:influxdb2"

    export PS1="[$SHELL_NAME|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  influxdb2 =
    pkgs.callPackage /data/projects/private/configuration.nix/packages/influxdb2
    { };

  buildInputs = [ influxdb2 ];
}
