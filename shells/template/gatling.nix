with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "template-shell-gatling";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    PROJECT_ROOT="$(pwd)"
    GATLING_HOME="$PROJECT_ROOT/runtime/gatling"

    [ ! -d "$GATLING_HOME" ] && {
      mkdir -p "$GATLING_HOME"

      pushd "$GATLING_HOME"
        gatling_base=$(dirname $(dirname $(which gatling.sh)))

        ln -fs "$gatling_base/conf"
        ln -fs "$gatling_base/lib"

        mkdir -p results
        mkdir -p user-files/bodies
        mkdir -p user-files/data
        mkdir -p user-files/simulations

        chmod -R 774 results
        chmod -R 774 user-files
      popd
    }

    export GATLING_HOME="$GATLING_HOME"
    export PS1="[${name}:\w]$ "
  '';

  gatling = pkgs.callPackage /data/projects/private/configuration.nix/packages/gatling {};

  buildInputs = [
    gatling
  ];
}
