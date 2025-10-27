{ config, pkgs, lib, ... }:
let
  inherit (lib) mkIf;
in
{
  # macOS でログイン時に podman machine start を実行
  launchd.agents.podman-machine-start = {
    enable = true;
    config = {
      ProgramArguments = [ "${pkgs.podman}/bin/podman" "machine" "start" ];
      RunAtLoad = true;
      KeepAlive = false;
      StandardOutPath = "${config.home.homeDirectory}/Library/Logs/podman-machine-start.out.log";
      StandardErrorPath = "${config.home.homeDirectory}/Library/Logs/podman-machine-start.err.log";
    };
  };
}
