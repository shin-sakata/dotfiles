{ ... }:
{
  enable = true;
  enableCompletion = true;
  enableAutosuggestions = true;

  sessionVariables = {
    NIX_PATH = "$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels\${NIX_PATH:+:$NIX_PATH}";
    # niv で private repository を利用するのに必要
    # https://github.com/nmattia/niv#2-use-the-netrc-file
    GITHUB_TOKEN = "$(gh auth token)";
    AWS_PROFILE = "dev28685203307";
  };
}
