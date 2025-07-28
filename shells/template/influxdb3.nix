with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "template-shell-influxdb3";

  shellHook = ''
    export PS1="[template:influxdb3|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  influxdb3 = pkgs.callPackage /data/projects/private/configuration.nix/packages/influxdb3 { };

  buildInputs = [
    influxdb3
  ];
}
