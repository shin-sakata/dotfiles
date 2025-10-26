{ lib, profileName, ... }:
let
  isHerpProfile = profileName == "herp";
in
{
  enable = true;
  userName = if isHerpProfile then "shin-sakata_herpinc" else "shin-sakata";
  userEmail = if isHerpProfile then "shintaro.sakata@herp.co.jp" else "shintaro.sakata.tokyo@gmail.com";
  extraConfig = {
    core.editor = "cursor --wait";
  };
  ignores = [
    ".direnv"
    "*.code-workspace"
    ".ctx"
  ];
}
