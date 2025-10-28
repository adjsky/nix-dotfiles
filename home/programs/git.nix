{
  enable = true;
  settings = {
    pull.default = "current";
    pull.rebase = true;
    fetch.prune = true;
    diff.colorMoved = "zebra";
    push.default = "current";
    core.editor = "nvim";
    alias.co = "checkout";
    includeif."gitdir:~/Programming/work/".path = "~/Programming/work/.gitconfig";
    includeif."gitdir:~/Programming/pers/".path = "~/Programming/pers/.gitconfig";
  };
}
