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
          doxx
          libnotify
          clang

          pandoc
          tectonic
          md2pdf

          jq
          fzf
          ripgrep
          bat

          python3
          spotify-player

          bluetui
          wiremix
          basalt

          vulkan-headers
          vulkan-tools
          vulkan-loader
          vulkan-validation-layers

          clang
          clang-tools

        ];

      };
    };

}
