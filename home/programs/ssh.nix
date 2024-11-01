{
  enable = true;
  matchBlocks = {
    "github-pers" = {
      hostname = "ssh.github.com";
      port = 443;
      identityFile = "~/.ssh/pers";
      identitiesOnly = true;
    };
    "github-work" = {
      hostname = "ssh.github.com";
      port = 443;
      identityFile = "~/.ssh/work";
      identitiesOnly = true;
    };
  };
}
