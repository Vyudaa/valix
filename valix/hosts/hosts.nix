{ inputs, self, ... }:
let
  istariCfg = import ./_istari.nix;
in
{
  flake = {
    nixosConfigurations = self.lib.mkNixos istariCfg.hostName istariCfg.system;

    homeConfigurations = {
      mithrandir = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        modules = with self.homeModules; [
          inputs.zen-browser.homeModules.beta
          zsh
          mithrandir
          ghostty
          tmux
          git
          nvim

          #Applications
          zen
          obsidian

          #Desktop Env
          rofi
          eww # TODO: configure this
          zathura
          hyprland
          hyprpaper
        ];
      };

    };
    diskoConfigurations = {
      ext4 = self.diskoModules.ext4;
    };
  };
}
