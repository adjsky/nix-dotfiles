{
  enable = true;
  extraConfig = {
    pull.default = "current";
    pull.rebase = true;
    fetch.prune = true;
    branch.autoSetupMerge = "always";
    branch.autoSetupRebase = "always";
    diff.colorMoved = "zebra";
    push.default = "current";
    core.editor = "nvim";
    includeif."gitdir:~/Programming/work/".path = "~/Programming/work/.gitconfig";
    includeif."gitdir:~/Programming/pers/".path = "~/Programming/pers/.gitconfig";
  };
}
