# Dotfiles

## Dependencies

- nix
- nix home manager


## Usage

### Initialize

```
$ git clone git@github.com:shin-sakata/dotfiles.git
$ bin/init
Checking if nix home manager is installed...
Installed nix home manager version is {version}
```

`ln: /Users/shin/.config/nixpkgs/home.nix: File exists` って出たら 拡張子を.bk(backup)とかにしてみてやってみるのはあり。
後々いい感じの構成に修正したい。

### Apply

```
$ home-manager switch
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
{ pkgs, lib }:
{
  enabled = true;
  # ...
}
```
