{ ... }:
{
  enable = true;
  enableCompletion = true;
  enableAutosuggestions = true;

  initExtra = builtins.readFile ../zsh/initExtra.sh;
}
