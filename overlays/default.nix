[
  (final: prev: {
    werf = prev.werf.overrideAttrs rec {
      version = "2.63.1";
      src = prev.fetchFromGitHub {
        owner = "werf";
        repo = "werf";
        rev = "v${version}";
        hash = "sha256-DRztwFKP3G5NyonyHtEMmHLDYgd0GAomEv3Kk1ANDsk=";
      };
      vendorHash = "sha256-DLDwZEKFOgzFvPOwJ99h/a7QVRHGgRHmWFue1JvmRh8=";
    };
  })
]
