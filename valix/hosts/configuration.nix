{ inputs, ... }:
{
  flake.modules.nixos.cfg =
    { pkgs, ... }:
    {

      nixpkgs.hostPlatform = "x86_64-linux";
      nixpkgs.config.allowUnfree = true;

      networking.hostName = "istari"; # Define your hostname.
      networking.enableIPv6 = true;
      networking.networkmanager.enable = true;

      time.timeZone = "America/Chicago";
      fonts.packages = with pkgs.nerd-fonts; [
        fira-code
      ];

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
      programs.git.enable = true;

      services.openssh.enable = true;

      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        withUWSM = true;
      };

      nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

      system.stateVersion = "25.11"; # Did you read the comment?

    };
}
