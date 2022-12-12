{ ... }:
{
  enable = true;
  enableCompletion = true;
  enableAutosuggestions = true;

  sessionVariables = {
    # for awscli & saml2aws
    AWS_DEFAULT_REGION = "ap-northeast-1";
    AWS_PROFILE = "saml";
  };

  initExtra = ''
    # nix daemon の起動
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi

    export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels''${NIX_PATH:+:$NIX_PATH}
  '';
}
