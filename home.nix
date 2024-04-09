{ config, pkgs, lib, ... }: {
  home.username = "shin";
  home.homeDirectory = "/Users/shin";

  home.stateVersion = "24.05";
  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.direnv
    pkgs.zsh
    pkgs.jetbrains-mono # for vscode
    pkgs.niv
    pkgs.cachix
  ];

  programs = import ./programs.nix { inherit pkgs lib; };

  home.file = {};
}
