with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "template-shell-cayley";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    PROJECT_ROOT="$(pwd)"
    SHELL_LOCK="$PROJECT_ROOT/runtime/cayley/shell.lock"
    SHELL_NAME="template:cayley"

    function finish {
      ps | grep 'cayley' | grep -v 'grep' | awk '{ print $1 }' | xargs kill

      rm -f "$SHELL_LOCK"
    }

    if [ ! -f "$SHELL_LOCK" ]; then
      mkdir -p "$(dirname "$SHELL_LOCK")"
      touch "$SHELL_LOCK"

      SHELL_NAME="$SHELL_NAME|\[\e[1m\]master\[\e[0m\]"

      cayley http 2>/dev/null &

      trap finish EXIT
    fi

    export ERL_AFLAGS="-kernel shell_history enabled"
    export PS1="[$SHELL_NAME|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  cayley =
    pkgs.callPackage /data/projects/private/configuration.nix/packages/cayley
    { };

  buildInputs = [ cayley ];
}
