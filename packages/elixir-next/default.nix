{ pkgs, stdenv, fetchFromGitHub, erlang, rebar, makeWrapper, coreutils, curl, bash,
  debugInfo ? false }:

stdenv.mkDerivation rec {
  name = "elixir-${version}";
  version = "1.6.0-dev-2017-10-11";

  src = fetchFromGitHub {
    owner = "elixir-lang";
    repo = "elixir";
    rev = "4b767c13d27d8ba39aea6e1da1485667dd5d3e51";
    sha256 = "06kiiz5f3vc3bf85p0vlc91inikvjx2n1h046y9i92514lfv1bq3";
  };

  buildInputs = [ erlang rebar makeWrapper ];

  LOCALE_ARCHIVE = stdenv.lib.optionalString stdenv.isLinux
    "${pkgs.glibcLocales}/lib/locale/locale-archive";

  LANG = "en_US.UTF-8";
  LC_TYPE = "en_US.UTF-8";

  setupHook = ./setup-hook.sh;

  inherit debugInfo;

  buildFlags = if debugInfo
   then "ERL_COMPILER_OPTIONS=debug_info"
   else "";

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
