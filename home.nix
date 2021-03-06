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
  nixpkgs.config.allowUnfree = true;

  home.packages = [
    # essential
    pkgs.direnv
    pkgs.vscodium
    pkgs.zsh
    pkgs.awscli2 # for saml2aws
    pkgs.saml2aws
    pkgs.jetbrains-mono # for vscodium
    pkgs.gh
    # for JavaScript
    pkgs.nodejs-16_x
    pkgs.yarn
    # for Haskell
    (pkgs.haskell-language-server.override { dynamic = true; })
    pkgs.stack
    pkgs.cabal-install
    pkgs.nixpkgs-fmt # for jnoortheen.nix-ide in vscode.extensions
    pkgs.haskellPackages.cabal-fmt # for runonsave in ./.vscode/settings.json
    pkgs.haskellPackages.hpack
    # for Ethereum
    pkgs.go-ethereum
  ];

  programs = import ./programs.nix { inherit pkgs lib; };

  home.file = {
    ".ghci".source = ./files/.ghci;
  };
}
