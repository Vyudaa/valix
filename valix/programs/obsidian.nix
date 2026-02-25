{
  flake.homeModules.obsidian = {
    programs.obsidian = {
      enable = true;
      vaults = {
        belogparth = {
          enable = true;
          target = "belogparth";
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
