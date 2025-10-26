{ config, pkgs, lib, ... }: {
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
    pkgs.nodejs_24
    pkgs.nodejs_24.pkgs.pnpm
    pkgs.podman
    pkgs.podman-compose
  ];

  imports = [
    ./programs/git.nix
    ./programs/direnv.nix
    ./programs/zsh.nix
    ./programs/home-manager.nix
  ];
}
