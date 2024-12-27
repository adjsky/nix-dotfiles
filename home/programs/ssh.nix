{ config }:
{
  enable = true;
  matchBlocks = {
    "github-pers" = {
      hostname = "ssh.github.com";
      port = 443;
      identityFile = config.sops.secrets."ssh/pers/private_key".path;
      identitiesOnly = true;
    };
    "github-work" = {
      hostname = "ssh.github.com";
      port = 443;
      identityFile = config.sops.secrets."ssh/work/private_key".path;
      identitiesOnly = true;
    };
    "adjika.dev" = {
      hostname = "194.164.34.55";
      user = "root";
      identityFile = config.sops.secrets."ssh/pers/private_key".path;
      identitiesOnly = true;
    };
  };
}
