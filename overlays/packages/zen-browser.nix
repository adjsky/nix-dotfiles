{
  fetchurl,
  stdenv,
  undmg,
}:

stdenv.mkDerivation rec {
  pname = "zen-browser";
  version = "1.0.1-a.18";

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.macos-aarch64.dmg";
    sha256 = "d6e98f861dfcfc5d520d2bf5880c9ab66c4c1af90ecf3476ca21b115a7764322";
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
