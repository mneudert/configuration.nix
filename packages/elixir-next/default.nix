{
  pkgs,
  lib,
  stdenv,
  fetchFromGitHub,
  erlang,
  makeWrapper,
  coreutils,
  curl,
  bash,
}:

stdenv.mkDerivation rec {
  name = "elixir-${version}";
  version = "1.20.0-dev-2025-11-14";

  src = fetchFromGitHub {
    owner = "elixir-lang";
    repo = "elixir";
    rev = "c80fc6da1accfdbef4c3499ee8812d6e14a7303f";
    hash = "sha256-ClYKt99SP2H+GAZ2Ii438Bs0s3STBMRosSQjfra2VVE=";
  };

  buildInputs = [
    erlang
    makeWrapper
  ];

  LOCALE_ARCHIVE = lib.optionalString stdenv.isLinux "${pkgs.glibcLocales}/lib/locale/locale-archive";

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
        --prefix PATH ":" "${
          lib.makeBinPath [
            erlang
            coreutils
            curl
            bash
          ]
        }" \
        --set CURL_CA_BUNDLE /etc/ssl/certs/ca-certificates.crt
    done

    substituteInPlace $out/bin/mix \
          --replace "/usr/bin/env elixir" "${coreutils}/bin/env elixir"
  '';
}
