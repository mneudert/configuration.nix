{ pkgs, stdenv, fetchFromGitHub, erlang, makeWrapper, coreutils, curl, bash }:

stdenv.mkDerivation rec {
  name = "elixir-${version}";
  version = "1.8.0-rc.0";

  src = fetchFromGitHub {
    owner = "elixir-lang";
    repo = "elixir";
    rev = "v1.8.0-rc.0";
    sha256 = "1xpnjbiqfpfgpn6i1w78m3j18i6pd7kbc5f81y1zhg6kaz1dhfb6";
  };

  buildInputs = [ erlang makeWrapper ];

  LOCALE_ARCHIVE = stdenv.lib.optionalString stdenv.isLinux
    "${pkgs.glibcLocales}/lib/locale/locale-archive";

  LANG = "en_US.UTF-8";
  LC_TYPE = "en_US.UTF-8";

  setupHook = ./setup-hook.sh;

  buildFlags = "ERL_COMPILER_OPTIONS=debug_info";

  preBuild = ''
    patchShebangs lib/elixir/generate_app.escript || true

    substituteInPlace Makefile \
      --replace "/usr/local" $out
  '';

  postFixup = ''
    # Elixir binaries are shell scripts which run erl. Add some stuff
    # to PATH so the scripts can run without problems.

    for f in $out/bin/*; do
     b=$(basename $f)
      if [ $b == "mix" ]; then continue; fi
      wrapProgram $f \
        --prefix PATH ":" "${stdenv.lib.makeBinPath [ erlang coreutils curl bash ]}" \
        --set CURL_CA_BUNDLE /etc/ssl/certs/ca-certificates.crt
    done

    substituteInPlace $out/bin/mix \
          --replace "/usr/bin/env elixir" "${coreutils}/bin/env elixir"
  '';
}
