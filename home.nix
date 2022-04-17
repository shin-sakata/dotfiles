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
    # utils
    pkgs.git
    pkgs.direnv
    pkgs.vscodium
    pkgs.zsh
    pkgs.gnumake
    # for Haskell
    pkgs.stack
    pkgs.cabal-install
    (pkgs.haskell-language-server.override { dynamic = true; })
    pkgs.nixpkgs-fmt # for jnoortheen.nix-ide in vscode.extensions
    pkgs.haskellPackages.cabal-fmt # for runonsave in ./.vscode/settings.json
  ];

  programs.git = {
    enable = true;
    userName = "shin-sakata";
    userEmail = "shintaro.sakata.tokyo@gmail.com";
    extraConfig = {
      core.editor = "codium --wait";
    };
    ignores = [
      ".direnv"
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.vscode = import ./programs/vscode.nix { inherit pkgs lib; };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    initExtra = ''
      # nix daemon の起動
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';
  };

  home.file = {
    ".ghci".source = ./files/.ghci;
  };
}
