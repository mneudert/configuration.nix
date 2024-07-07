{ pkgs, lib, stdenv, fetchFromGitHub, erlang, makeWrapper, coreutils, curl, bash
}:

stdenv.mkDerivation rec {
  name = "elixir-${version}";
  version = "1.18.0-dev-2024-07-07";

  src = fetchFromGitHub {
    owner = "elixir-lang";
    repo = "elixir";
    rev = "18bbfed45ef2698066436adae00ddf877644b55d";
    hash = "sha256-bwG+0Vj/e++Kx998cdM+OGPbII0v3CCEU5b/eqAHUa4=";
  };

  buildInputs = [ erlang makeWrapper ];

  LOCALE_ARCHIVE = lib.optionalString stdenv.isLinux
    "${pkgs.glibcLocales}/lib/locale/locale-archive";

  LANG = "en_US.UTF-8";
  LC_TYPE = "en_US.UTF-8";

  buildFlags = "ERL_COMPILER_OPTIONS=debug_info";

  preBuild = ''
    patchShebangs lib/elixir/scripts/generate_app.escript || true

    substituteInPlace Makefile --replace "/usr/local" $out
    echo -n $version > VERSION
  '';

  postFixup = ''
    # Elixir binaries are shell scripts which run erl. Add some stuff
    # to PATH so the scripts can run without problems.

    for f in $out/bin/*; do
     b=$(basename $f)
      if [ $b == "mix" ]; then continue; fi
      wrapProgram $f \
        --prefix PATH ":" "${lib.makeBinPath [ erlang coreutils curl bash ]}" \
        --set CURL_CA_BUNDLE /etc/ssl/certs/ca-certificates.crt
    done

    substituteInPlace $out/bin/mix \
          --replace "/usr/bin/env elixir" "${coreutils}/bin/env elixir"
  '';
}
