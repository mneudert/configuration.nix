with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "template-shell-influxdb2";

  shellHook = ''
    export PS1="[template:influxdb2|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  influxdb2 = pkgs.callPackage /data/projects/private/configuration.nix/packages/influxdb2 { };

  influxdb2-client =
    pkgs.callPackage /data/projects/private/configuration.nix/packages/influxdb2-client
      { };

  buildInputs = [
    influxdb2
    influxdb2-client
  ];
}
