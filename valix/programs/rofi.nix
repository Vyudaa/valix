{

  flake.homeModules.rofi =
    { pkgs, ... }:
    {
      programs.rofi = {
        enable = true;
        package = pkgs.rofi;
        modes = [
          "drun"
          "run"
          "window"
          "ssh"
        ];
        extraConfig = {
          show-icons = true;
        };
      };
    };
}
