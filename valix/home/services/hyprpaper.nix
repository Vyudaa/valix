{
  flake.homeModules.hyprpaper =
    { pkgs, ... }:
    {
      services.hyprpaper = {
        enable = true;
        settings = {
          ipc = "on";
          splash = false;
          splash_offset = 2.0;

          preload = [
            "/home/mithrandir/Downloads/rivendale.jpg"
          ];

          wallpaper = [
            "eDP-1,/home/mithrandir/Downloads/rivendale.jpg"
          ];
        };
      };
    };
}
