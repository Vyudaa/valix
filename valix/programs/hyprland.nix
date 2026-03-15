# TODO:
#   - [ ] If only one window default to fullscreen,

{
  flake.homeModules.hyprland =
    { pkgs, ... }:
    {
      wayland.windowManager.hyprland = {
        enable = true;

        submaps = {
          resize.settings = {
            binde = [
              ", right, resizeactive, 10 0"
              ", left, resizeactive, -10 0"
              ", up, resizeactive, 0 -10"
              ", down, resizeactive, 0 10"
            ];
            bind = [
              ", ESCAPE, submap, reset"
              ", RETURN, submap, reset"
            ];
          };
          nvim.settings = {
            bind = [
              ", D, exec, hyprctl dispatch submap reset; ghostty --working-directory=/etc/valix/ -e nvim ."
              ", ESCAPE, submap, reset"
            ];
          };

        };
        settings = {
          "$mod" = "SUPER";
          "$terminal" = "ghostty";
          "$browser" = "zen-beta";
          "$green" = "a7c080";
          monitor = [
            "eDP-1,preferred, auto, auto"
            "DP-5,preferred,auto,auto"
          ];
          workspace = [
            "special:scratchpad, gapsout:30, border:false"
            "special:terminal, gapsout:30, border:false, on-created-empty: $terminal"
            "special:obsidian, gapsout:30, border:false, on-created-empty: ghostty --working-directory=/home/mithrandir/vaults/Istya/ -e nvim ."
            "1,monitor:eDP-1"
            "2,monitor:DP-5"
            "3,monitor:DP-5"
            "4,monitor:DP-5"
          ];

          bind = [

            "$mod, P, workspace, previous"

            "$mod, RETURN, exec, $terminal"
            # Figure out if its possible to check whether $browser is currently running
            "$mod, B, exec, $browser"
            "$mod, F, fullscreen, toggle"
            "$mod, Q, killactive"
            "$mod, M, exit"
            "$mod, S, togglespecialworkspace, scratchpad"
            "$mod, T, togglespecialworkspace, terminal"
            "$mod, O, togglespecialworkspace, obsidian"
            "$mod, SPACE, exec, rofi -show drun"

            "$mod, 1, workspace, 1"
            "$mod, 2, workspace, 2"
            "$mod, 3, workspace, 3"
            "$mod, 4, workspace, 4"

            "$mod SHIFT, 1, movetoworkspace, 1"
            "$mod SHIFT, 2, movetoworkspace, 2"
            "$mod SHIFT, 3, movetoworkspace, 3"
            "$mod SHIFT, 4, movetoworkspace, 4"

            "$mod, R, submap, resize"
            "$mod, N, submap, nvim"
            ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
            ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
            ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
            ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
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
