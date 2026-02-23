{ inputs, ... }:
{
  flake.modules.nixos.cfg = {


    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      configurationLimit = 5;
    };

    nixpkgs.hostPlatform = "x86_64-linux";
    nixpkgs.config.allowUnfree = true;

    networking.hostName = "istari"; # Define your hostname.
    networking.networkmanager.enable = true;

    time.timeZone = "America/Chicago";

    i18n.defaultLocale = "en_US.UTF-8";
    console = {
      font = "Lat2-Terminus16";
      keyMap = "us";
    };

        programs.zsh.enable = true;

    users.users.mithrandir = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      shell = inputs.nixpkgs.legacyPackages.x86_64-linux.zsh;
      packages = with inputs.nixpkgs.legacyPackages.x86_64-linux; [
        home-manager
      ];

    };

    environment.systemPackages = with inputs.nixpkgs.legacyPackages.x86_64-linux; [
      vim
      git
    ];

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    programs.git.enable =true;

    services.openssh.enable = true;

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };

    system.stateVersion = "25.11"; # Did you read the comment?

  };
}
