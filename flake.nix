{
  description = "Home Manager configuration of shin";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    codex.url = "github:herp-inc-hq/codex";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, codex, home-manager, ... }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations = {
        herp = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            {
              _module.args.profileName = "herp";
              nixpkgs.overlays = [ codex.overlays.default ];
              codex.enable = true;

              imports = [
                ./home.nix
                codex.homeModules.default
              ];
            }
          ];
        };

        shin = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            {
              _module.args.profileName = "shin";
              imports = [
                ./home.nix
              ];
            }
          ];
        };
      };
    };
}
