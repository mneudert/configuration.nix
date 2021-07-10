with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "template-shell-gatling";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    PROJECT_ROOT="$(pwd)"
    GATLING_HOME="$PROJECT_ROOT/runtime/gatling"

    function setup_gatling {
      mkdir -p "$GATLING_HOME"

      pushd "$GATLING_HOME" > /dev/null
        ln -fs "${gatling}/conf"
        ln -fs "${gatling}/lib"

        mkdir -p results
        mkdir -p user-files/bodies
        mkdir -p user-files/data
        mkdir -p user-files/simulations
      popd > /dev/null
    }

    setup_gatling

    export GATLING_HOME="$GATLING_HOME"
    export PS1="[template:gatling|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  gatling =
    pkgs.callPackage /data/projects/private/configuration.nix/packages/gatling
    { };

  buildInputs = [ gatling ];
}
