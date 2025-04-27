{ ... }:
{
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;

  initExtra = builtins.readFile ../zsh/initExtra.zsh;
}
