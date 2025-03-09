{
  fetchurl,
  stdenv,
  undmg,
}:

stdenv.mkDerivation rec {
  pname = "zen-browser";
  version = "1.9b";

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.macos-universal.dmg";
    sha256 = "230b33d3f1cd0cc23f9e8341ec54f8b531e41fca575a01fa03492c47f07492e3";
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
