{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.istari = {
    imports = with inputs.self.modules.nixos; [
      hardware
      cfg
      grub

      #TODO: move this to a top-level module for linux hosts
      inputs.disko.nixosModules.disko
      self.diskoConfigurations.ext4
    ];
  };
}
