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
          confirm-close-surface = false;
          window-padding-x = 0;
          window-padding-y = 0;
          window-padding-balance = true;
          keybind = [
            "alt+v=paste_from_clipboard"
            "alt+c=copy_to_clipboard"
          ];
        };
      };
    };
}
