{ ... }:
{
  enable = true;
  userName = "shin-sakata";
  userEmail = "shintaro.sakata.tokyo@gmail.com";
  extraConfig = {
    core.editor = "code --wait";
  };
  ignores = [
    ".direnv"
    "*.code-workspace"
    ".ctx"
  ];
}
