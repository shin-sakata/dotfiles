{ pkgs, lib, ... }:
{
  enable = true;
  package = pkgs.vscodium;
  # このプロジェクトの ./.vscode/settings.json をグローバルなVSCodeの設定として用いる
  userSettings = lib.trivial.importJSON ../.vscode/settings.json;
  extensions = (with pkgs.vscode-extensions;
    [
      jnoortheen.nix-ide
      pkief.material-icon-theme
      ms-ceintl.vscode-language-pack-ja
      justusadam.language-haskell
      arrterian.nix-env-selector
      redhat.vscode-yaml # for swagger-viewer
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "runonsave";
      publisher = "emeraldwalk";
      version = "0.2.0";
      sha256 = "nPm9bTEnNHzb5omGoEh0e8Wp+XTLW2UTtr/OuSBd99g=";
    }
    {
      name = "haskell";
      publisher = "haskell";
      version = "2.0.0";
      sha256 = "dmfOS3KIaLsMl+aO+BSBwthVIAyDJRtPLPjcVzqdKOE=";
    }
    {
      name = "swagger-viewer";
      publisher = "arjun";
      version = "3.1.2";
      sha256 = "ldrwo1mt4GostzRpo8d6KbegCtW5L7tFHLzg0FNiW7I=";
    }
  ];
}