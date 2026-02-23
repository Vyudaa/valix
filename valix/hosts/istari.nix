{ inputs, self, ... }:
{
  flake = {
    nixosConfigurations = {
      istari = inputs.nixpkgs.lib.nixosSystem {
        modules = with self.modules; [
          inputs.disko.nixosModules.disko
          self.diskoConfigurations.ext4
          nixos.cfg
          nixos.hardware
        ];
      };
    };
    homeConfigurations = {
      mithrandir = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        modules = with self.homeModules; [
          inputs.zen-browser.homeModules.beta
          inputs.nixvim.homeModules.nixvim
          zsh
          mithrandir
          hyprland
          ghostty
          zen
          nixvim
          obsidian
        git
        ];
      };

    };
    diskoConfigurations = {
      ext4 = self.diskoModules.ext4;
    };
  };
}
