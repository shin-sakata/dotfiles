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

  home.packages = [
    # essential
    pkgs.binutils
    pkgs.git
    pkgs.direnv
    pkgs.vscodium
    pkgs.zsh
    pkgs.gnumake
    pkgs.awscli # for saml2aws
    pkgs.saml2aws
    pkgs.jetbrains-mono # for vscodium
    # for Haskell
    pkgs.ghc
    pkgs.cabal-install
    (pkgs.haskell-language-server.override { dynamic = true; })
    pkgs.nixpkgs-fmt # for jnoortheen.nix-ide in vscode.extensions
    pkgs.haskellPackages.cabal-fmt # for runonsave in ./.vscode/settings.json
    # for Scala3
    pkgs.jdk17_headless
    pkgs.sbt
  ];

  programs = import ./programs.nix { inherit pkgs lib; };

  home.file = {
    ".ghci".source = ./files/.ghci;
  };
}
