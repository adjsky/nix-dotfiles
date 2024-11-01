{
  enable = true;
  extraConfig = {
    pull.rebase = true;
    fetch.prune = true;
    diff.colorMoved = "zebra";
    push.default = "current";
    core.editor = "nvim";
    includeif."gitdir:~/Programming/work/".path = "~/Programming/work/.gitconfig";
    includeif."gitdir:~/Programming/pers/".path = "~/Programming/pers/.gitconfig";
  };
}
