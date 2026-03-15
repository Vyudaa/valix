{
  flake.homeModules.nvim =
    { pkgs, lib, ... }:
    {
      programs.neovim = {
        enable = true;
        vimAlias = true;
        viAlias = true;
        plugins = with pkgs.vimPlugins; [

          snacks-nvim
          todo-comments-nvim
          # Formatting
          conform-nvim
          obsidian-nvim

          nvim-autopairs
          #Completion
          blink-cmp
          fzf-lua
          # Colorschemes
          everforest

          plenary-nvim

          (nvim-treesitter.withPlugins (p: [
            p.lua
            p.latex
            p.nix

          ]))
        ];
        extraPackages = with pkgs; [
          python313Packages.pylatexenc
          tree-sitter

          nixd
          nixfmt

          lua-language-server
          stylua

          prettierd
        ];
      };
      xdg.configFile = {
        "nvim/lua" = {
          source = ./nvim/lua;
          recursive = true;
        };

        "nvim/lsp" = {
          source = ./nvim/lsp;
          recursive = true;
        };
        "nvim/init.lua".source = ./nvim/init.lua;
      };
    };

}
