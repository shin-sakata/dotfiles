{ ... }:
{
  programs.git = {
    enable = true;
    extraConfig = {
      core.editor = "cursor --wait";
      include.path = "~/.gitconfig-default";
      includeIf."gitdir:/Users/shin/Projects/herp-inc/".path = "~/.gitconfig-herpinc";
    };
    ignores = [
      ".direnv"
      "*.code-workspace"
      ".ctx"
    ];
  };

  home.file.".gitconfig-herpinc".text = ''
    [user]
      name = shin-sakata_herpinc
      email = shintaro.sakata@herp.co.jp
    [credential]
      useHttpPath = true
      username = shin-sakata_herpinc
  '';
  home.file.".gitconfig-default".text = ''
    [user]
      name = shin-sakata
      email = shintaro.sakata.tokyo@gmail.com
    [url "git@github.com:shin-sakata/"]
      insteadOf = https://github.com/shin-sakata/
      pushInsteadOf = https://github.com/shin-sakata/
  '';
}
