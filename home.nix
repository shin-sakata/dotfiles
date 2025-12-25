{ config, pkgs, lib, ... }: {
  home.username = "shin";
  home.homeDirectory = "/Users/shin";

  home.stateVersion = "25.11";
  nixpkgs.config.allowUnfree = true;

  # 25.11 から macOS では `targets.darwin.copyApps` がデフォルト有効になり、
  # `~/Applications/Home Manager Apps` へ rsync でコピーします。
  # 環境によっては権限/ACL で失敗するため明示的に無効化します。
  targets.darwin.copyApps.enable = false;

  home.packages = [
    pkgs.direnv
    pkgs.zsh
    pkgs.jetbrains-mono # for vscode
    pkgs.niv
    pkgs.cachix
    pkgs.kustomize
    pkgs.nodejs_24
    pkgs.nodejs_24.pkgs.pnpm
    pkgs.nodejs_24.pkgs.yarn
    pkgs.podman
    pkgs.podman-compose
    (pkgs.writeShellScriptBin "docker" ''exec podman "$@"'')
    (import ./pkgs/moonbit-wasm-toolchain.nix { inherit pkgs; })
  ];

  imports = [
    ./programs/git.nix
    ./programs/direnv.nix
    ./programs/zsh.nix
    ./programs/home-manager.nix
    ./programs/podman-machine.nix
  ];

  home.file = {
    ".ssh/config".text = ''
      Host *
        IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';
  };
}
