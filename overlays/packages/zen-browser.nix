{
  fetchurl,
  stdenv,
  undmg,
}:

stdenv.mkDerivation rec {
  pname = "zen-browser";
  version = "1.0.1-a.19";

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.macos-aarch64.dmg";
    sha256 = "228f79a57cc8077af46ce5407008b32193e1b01823eaf7fa27a21c39f340b4cf";
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
