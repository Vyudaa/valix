{
    flake.modules.nixos.grub = {...}:  {
        boot.loader.efi.canTouchEfiVariables = true;
        boot.loader.grub = {
            enable = true;
            device = "nodev";
            efiSupport = true;
            configurationLimit = 5;
        };
    };
}
