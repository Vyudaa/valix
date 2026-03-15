{
  flake.homeModules.rofi =
    { pkgs, ... }:
    {
      programs.rofi = {
        enable = true;
      };
    };

}
