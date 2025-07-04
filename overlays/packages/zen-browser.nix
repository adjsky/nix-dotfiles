{
  fetchurl,
  stdenv,
  undmg,
}:

stdenv.mkDerivation rec {
  pname = "zen-browser";
  version = "1.14b";

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.macos-universal.dmg";
    sha256 = "sha256-0CZdzgt4X/jBEqAYZpFSaxzhV6+63BxpZlgQ/D+w72w=";
  };

  nativeBuildInputs = [ undmg ];

  sourceRoot = "Zen.app";

  installPhase = ''
    mkdir -p "$out/Applications/Zen Browser.app"
    cp -R . "$out/Applications/Zen Browser.app"
  '';

  meta = {
    platforms = [ "aarch64-darwin" ];
  };
}
