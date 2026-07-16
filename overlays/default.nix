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
    commitizen = prev.commitizen.overrideAttrs rec {
      version = "4.16.4";
      src = prev.fetchFromGitHub {
        owner = "commitizen-tools";
        repo = "commitizen";
        tag = "v${version}";
        hash = "sha256-lVc1Kdy/IWRa8uoPZfOSSa379bDDknE3dpm0U7DVv0s=";
      };
      postPatch = ''
        substituteInPlace pyproject.toml \
          --replace-fail "uv_build >= 0.9.17, <0.12" "uv-build"
      '';
      makeWrapperArgs = [
        "--prefix"
        "PATH"
        ":"
        (prev.lib.makeBinPath [ prev.gitMinimal ])
      ];
    };
  })
]
