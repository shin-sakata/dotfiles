{ ... }:
{
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;

  initContent = builtins.readFile ../zsh/initContent.zsh;
}
