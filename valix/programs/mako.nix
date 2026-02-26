{
  flake.homeModules.mako =
    { pkgs, ... }:
    {
      services.mako = {
        enable = true;
        settings = {
          "actionable=true" = {
            anchor = "top-left";
          };
          actions = true;
          anchor = "top-right";
          icons = true;
        };
      };
    };
}
