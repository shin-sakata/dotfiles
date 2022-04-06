{ config, pkgs, lib, ... }:
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "shin";
  home.homeDirectory = "/Users/shin";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.git
    pkgs.direnv
    pkgs.vscodium
    pkgs.nixpkgs-fmt # for jnoortheen.nix-ide in vscode.extensions
    pkgs.haskellPackages.cabal-fmt # for runonsave in ./.vscode/settings.json
  ];

  programs.git = {
    enable = true;
    userName = "shin-sakata";
    userEmail = "shintaro.sakata.tokyo@gmail.com";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    userSettings = lib.trivial.importJSON ./.vscode/settings.json;
    # https://github.com/nix-community/home-manager/blob/7cf15b19a931b99f9a918887fc488d577fd07516/modules/programs/vscode.nix#L151
    # extensionのdirectoryをこのファイルでしかいじれなくする設定
    mutableExtensionsDir = false;
    extensions = (with pkgs.vscode-extensions;
      [
        jnoortheen.nix-ide
        pkief.material-icon-theme
        ms-ceintl.vscode-language-pack-ja
        justusadam.language-haskell
        arrterian.nix-env-selector
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
    ];
  };
}
