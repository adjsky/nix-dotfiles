{
  fetchurl,
  stdenv,
  undmg,
}:

stdenv.mkDerivation rec {
  pname = "zen-browser";
  version = "1.0.1-a.17";

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.macos-aarch64.dmg";
    sha256 = "6c3d3563b81ffbe7a071bf6f76af88a1db361d3adaca14558df80b9215d5012d";
  };

  nativeBuildInputs = [ undmg ];

  sourceRoot = "Zen Browser.app";

  installPhase = ''
    mkdir -p "$out/Applications/Zen Browser.app"
    cp -R . "$out/Applications/Zen Browser.app"
  '';

  meta = {
    platforms = [ "aarch64-darwin" ];
  };
}
