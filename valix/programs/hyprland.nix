{
  flake.homeModules.hyprland =
    { pkgs, ... }:
    {
      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          "$mod" = "SUPER";
          "$terminal" = "ghostty";
          "$browser" = "zen-beta";

          "$green" = "a7c080";

          monitor = [
            ",preferred, auto, auto"
          ];
          workspace = [
            "special:scratchpad, gapsout:30, border:false"
          ];

          bind = [

            "$mod, SPACE, exec, rofi -show drun"
            "$mod, RETURN, exec, $terminal"
            "$mod, B, exec, $browser"
            "$mod, Q, killactive"
            "$mod, M, exit"
            "$mod, O, exec, obsidian"

            "$mod, S, togglespecialworkspace, scratchpad"

            "$mod, 1, workspace, 1"
            "$mod, 2, workspace, 2"
            "$mod, 3, workspace, 3"
            "$mod, 4, workspace, 4"

            "$mod SHIFT, 1, movetoworkspace, 1"
            "$mod SHIFT, 2, movetoworkspace, 2"
            "$mod SHIFT, 3, movetoworkspace, 3"
            "$mod SHIFT, 4, movetoworkspace, 4"
          ];

          input = {
            kb_layout = "us";
            kb_options = [
              "ctrl:nocaps"
            ];
            follow_mouse = 1;
            sensitivity = 0;
          };
          general = {
            layout = "dwindle";
            gaps_in = 5;
            gaps_out = 20;
            border_size = 2;
            resize_on_border = true;
            "col.active_border" = "rgba($greenee)";
            "col.inactive_border" = "rgba(595959aa)";
          };
          misc = {
            force_default_wallpaper = 0;
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
          };
          animations = {
            enabled = false;
          };
        };
      };
    };
}
