{
  flake.homeModules.ghostty =
    { pkgs, ... }:
    {
      programs.ghostty = {
        enable = true;
        settings = {
          font-family = "FiraCode Nerd Font Mono Reg";
          theme = "Everforest Dark Hard";
            background-opacity = 0.7;

        };
      };
    };
}
