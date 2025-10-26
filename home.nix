{ config, pkgs, lib, profileName, ... }: {
  home.username = "shin";
  home.homeDirectory = "/Users/shin";

  home.stateVersion = "25.05";
  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.direnv
    pkgs.zsh
    pkgs.jetbrains-mono # for vscode
    pkgs.niv
    pkgs.cachix
    pkgs.kustomize
    pkgs.nodejs-slim_20
    pkgs.nodejs-slim_20.pkgs.pnpm
    pkgs.android-tools
    pkgs.scrcpy
    pkgs.claude-code
  ];

  programs = import ./programs.nix { inherit pkgs lib profileName; };

  home.file = {};
}
