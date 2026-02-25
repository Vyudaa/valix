{
  flake.homeModules.eww =
    { pkgs, ... }:
    {
      programs.eww = {
        enable = true;
        configDir = ./eww-config-dir;
      };
    };
}
