{ ... }:
{
  enable = true;
  enableCompletion = true;
  enableAutosuggestions = true;

  sessionVariables = {
    # niv で private repository を利用するのに必要
    # https://github.com/nmattia/niv#2-use-the-netrc-file
    GITHUB_TOKEN = "$(gh auth token)";
  };
}
