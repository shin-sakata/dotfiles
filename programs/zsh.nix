{ ... }:
{
  enable = true;
  enableCompletion = true;
  enableAutosuggestions = true;
  initExtra = ''
    # nix daemon の起動
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
  '';
}
