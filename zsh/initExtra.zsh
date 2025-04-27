eval "$(codex configure zsh)"
# niv で private repository を利用するのに必要
# https://github.com/nmattia/niv#2-use-the-netrc-file
export GITHUB_TOKEN=$(gh auth token)
