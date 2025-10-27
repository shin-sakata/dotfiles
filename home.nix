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
    (pkgs.writeShellScriptBin "docker" ''exec podman "$@"'')
  ];

  imports = [
    ./programs/git.nix
    ./programs/direnv.nix
    ./programs/zsh.nix
    ./programs/home-manager.nix
    ./programs/podman-machine.nix
  ];

  home.file.".ssh/config".text = ''
    Host *
      IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
  '';
}
