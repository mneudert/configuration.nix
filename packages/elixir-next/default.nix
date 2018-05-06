{ pkgs, stdenv, fetchFromGitHub, erlang, rebar, makeWrapper, coreutils, curl, bash }:

stdenv.mkDerivation rec {
  name = "elixir-${version}";
  version = "1.7.0-dev-2018-05-04";

  src = fetchFromGitHub {
    owner = "elixir-lang";
    repo = "elixir";
    rev = "f51865bd148d6d5f4fc02cfe441b2c1802dcc9ca";
    sha256 = "14x51j8y67la8cmwndaqwhh7p9mmy4gqr31ylq0hqbp54llzqzq3";
  };

  buildInputs = [ erlang rebar makeWrapper ];

  LOCALE_ARCHIVE = stdenv.lib.optionalString stdenv.isLinux
    "${pkgs.glibcLocales}/lib/locale/locale-archive";

  LANG = "en_US.UTF-8";
  LC_TYPE = "en_US.UTF-8";

  setupHook = ./setup-hook.sh;

  buildFlags = "ERL_COMPILER_OPTIONS=debug_info";

  preBuild = ''
    # The build process uses ./rebar. Link it to the nixpkgs rebar
    rm -v rebar
    ln -s ${rebar}/bin/rebar rebar

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
