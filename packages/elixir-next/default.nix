{ pkgs, lib, stdenv, fetchFromGitHub, erlang, makeWrapper, coreutils, curl, bash
}:

stdenv.mkDerivation rec {
  name = "elixir-${version}";
  version = "1.14.0-dev-2022-05-22";

  src = fetchFromGitHub {
    owner = "elixir-lang";
    repo = "elixir";
    rev = "0d37cc2fd83e66a2fc5f6221f8917f8c5473c956";
    hash = "sha256-JSySPdlKmciGHReCmZwTUG27rb5xiRMbXxNnci59ins=";
  };

  buildInputs = [ erlang makeWrapper ];

  LOCALE_ARCHIVE = lib.optionalString stdenv.isLinux
    "${pkgs.glibcLocales}/lib/locale/locale-archive";

  LANG = "en_US.UTF-8";
  LC_TYPE = "en_US.UTF-8";

  buildFlags = "ERL_COMPILER_OPTIONS=debug_info";

  preBuild = ''
    patchShebangs lib/elixir/generate_app.escript || true

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
