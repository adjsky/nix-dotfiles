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
  };
}
