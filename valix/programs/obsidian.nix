{
  flake.homeModules.obsidian =
    { pkgs, ... }:
    {
      programs.obsidian = {
        enable = true;
        vaults = {
          Ore = {
            enable = true;
            target = "vaults/Istya";
            settings = {
              appearance = {
                theme = "obsidian";
              };
            };
          };

        };
      };
    };
}
