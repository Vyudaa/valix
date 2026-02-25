{

  flake.homeModules.mithrandir =
    { pkgs, ... }:
    {
      home = {
        username = "mithrandir";
        homeDirectory = "/home/mithrandir";
        stateVersion = "25.11";

        packages = with pkgs; [
          nixfmt
          super-tiny-icons
          firefoxpwa
          jq
        ];
      };
    };

}
