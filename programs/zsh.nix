{ ... }:
{
  enable = true;
  enableCompletion = true;
  enableAutosuggestions = true;

  sessionVariables = {
    # for awscli & saml2aws
    AWS_DEFAULT_REGION = "ap-northeast-1";
    AWS_PROFILE = "saml";
    NIX_PATH = "$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels\${NIX_PATH:+:$NIX_PATH}";
    GITHUB_TOKEN = "$(gh auth token)";
  };

  initExtra = ''
    # nix daemon の起動
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi

    # niv で private repository を利用するのに必要
    # https://github.com/nmattia/niv#2-use-the-netrc-file
    export GITHUB_TOKEN=$(gh auth token)
  '';
}
