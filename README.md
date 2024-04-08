# Dotfiles

## Dependencies

- nix

## Usage

### Initialize

```
$ git clone git@github.com:shin-sakata/dotfiles.git
$ ./utils/init
```

### Apply

```
$ ./utils/switch {configurationName}
```

### Settings

下記のような設定をしたい場合がよくある

```nix home.nix
# home.nix
{
  programs.git = {
    enabled = true;
    # ...
  }
}
```

その場合は `programs/git.nix` を作り下記のように記述すると良い感じに適用されるようになっている

```nix programs/git.nix
# ./programs/git.nix

{ pkgs, lib }:
{
  enabled = true;
  # ...
}
```
