{ pkgs, lib, stdenv, fetchFromGitHub, erlang, makeWrapper, coreutils, curl, bash
}:

stdenv.mkDerivation rec {
  name = "elixir-${version}";
  version = "1.18.0-dev-2024-11-27";

  src = fetchFromGitHub {
    owner = "elixir-lang";
    repo = "elixir";
    rev = "12780b15dd12a61da3d952c407df8571e4f68ec1";
    hash = "sha256-khy2fKCVUrMJ0Ids8PnOdNX8SRynvgstzh61PjhpXWc=";
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
