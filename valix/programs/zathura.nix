{
  flake.homeModules.zathura =
    { pkgs, ... }:
    {
      programs.zathura = {
        enable = true;

        options = {

          font = "fira-code 15";

          default-bg = "#1E2326";
          default-fg = "#d3c6aa";

          statusbar-fg = "#a7c080";
          statusbar-bg = "#3c474d";

          inputbar-bg = "#323c41";
          inputbar-fg = "#d3c6aa";

          notification-error-bg = "#e67e80";
          notification-error-fg = "#2b3339";

          notification-warning-bg = "#dbbc7f";
          notification-warning-fg = "#2b3339";

          notification-bg = "#7fbbb3";
          notification-fg = "#2b3339";

          highlight-color = "#dbbc7f";
          highlight-active-color = "#7fbbb3";

          completion-highlight-fg = "#2b3339";
          completion-highlight-bg = "#a7c080";

          completion-bg = "#3a454a";
          completion-fg = "#d3c6aa";

          recolor = "true";
          recolor-lightcolor = "rgba(43, 51, 57, 0)"; # transparent bg
          recolor-darkcolor = "rgba(211, 198, 170, 1)"; # fg (text)
          recolor-reverse-video = "true";
          recolor-keephue = "true";
        };

      };
    };
}
