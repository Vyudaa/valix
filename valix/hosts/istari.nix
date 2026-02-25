{
    inputs,
    self,
    ...
}:
{
    flake.modules.nixos.istari = {
        imports = with inputs.self.modules.nixos; [
                grub
                hardware
                cfg
                inputs.disko.nixosModules.disko
                self.diskoConfigurations.ext4
        ];
    };
}
