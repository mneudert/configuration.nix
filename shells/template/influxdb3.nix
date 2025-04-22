with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "template-shell-influxdb3";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    SHELL_NAME="template:influxdb3"

    export PS1="[$SHELL_NAME|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  influxdb3 = pkgs.callPackage /data/projects/private/configuration.nix/packages/influxdb3 { };

  buildInputs = [
    influxdb3
  ];
}
