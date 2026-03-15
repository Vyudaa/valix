{
  flake.homeModules.obsidian =
    { pkgs, ... }:
    {
      programs.obsidian = {
        enable = true;
        defaultSettings = {
          appearance = {
            theme = "obsidian";
            cssTheme = "Everforest";
          };
          corePlugins = [
            "backlink"
            "graph"
            "daily-notes"
            "command-palette"
            "templates"

          ];
        };
        vaults = {
          Istya = {
            enable = true;
            target = "vaults/Istya";
          };
        };
      };
    };
}
