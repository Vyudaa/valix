{
  flake.homeModules.nixvim =
    { pkgs, ... }:
    {
      programs.nixvim = {

        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;

        clipboard = {
          register = "unnamedplus";
        };
        globals = {
          mapleader = " ";
          maplocalleader = " ";
          netrw_banner = 0;
        };
        opts = {
          updatetime = 100; # fast completion
          relativenumber = true;
          number = true;
          splitbelow = true;
          splitright = true;
          swapfile = false;
          undofile = true;
          incsearch = true;
          inccommand = "split";
          ignorecase = true;
          smartcase = true;
          scrolloff = 8;
          cursorline = true;
          termguicolors = true;
          wrap = false;
          tabstop = 4;
          shiftwidth = 4;
          expandtab = true;
          autoindent = true;
        };

        keymaps = [
          {
            mode = [ "n" ];
            key = "<leader>e";
            action = ":Ex<cr>";
            options = {
              silent = true;
            };

          }
          {
            mode = [ "v" ];
            key = "J";
            action = ":m '>+1<CR>gv=gv";
            options = {
              silent = true;
            };

          }
          {
            mode = [ "v" ];
            key = "K";
            action = ":m '<-2<CR>gv=gv";
            options = {
              silent = true;
            };

          }
          {
            mode = [ "n" ];
            key = "J";
            action = "mzJ`z";
            options = {
              silent = true;
            };

          }
          {
            mode = [ "n" ];
            key = "<C-d>";
            action = "<C-d>zz";
            options = {
              silent = true;
            };

          }
          {
            mode = [ "n" ];
            key = "<C-u>";
            action = "<C-u>zz";
            options = {
              silent = true;
            };

          }
          {
            mode = [ "n" ];
            key = "n";
            action = "nzzzv";
            options = {
              silent = true;
            };

          }
          {
            mode = [ "n" ];
            key = "N";
            action = "Nzzzv";
            options = {
              silent = true;
            };

          }
          {
            mode = [ "i" ];
            key = "<C-c>";
            action = "<ESC>";
            options = {
              silent = true;
            };
          }
          {
            mode = [ "n" ];
            key = "<leader>u";
            action = ":UndotreeToggle<cr>";
            options = {
              silent = true;
            };

          }

        ];
        colorschemes = {
          everforest = {
            enable = true;
          };
        };

        extraPlugins = with pkgs.vimPlugins; [

          blink-pairs
        ];

        plugins = {

          undotree = {
            enable = true;
          };

          treesitter = {
            enable = true;

            grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
              nix
              vim
            ];
            settings = {
              indent.enable = true;
              highlight.enable = true;
            };

          };
          fzf-lua = {
            enable = true;
            keymaps = {
              "<leader>ff" = "files";
              "<leader>fw" = "live_grep";
            };

          };

          blink-cmp = {
            enable = true;
            setupLspCapabilities = true;
            settings = {
              completion = {
                accept = {
                  auto_brackets = {
                    enabled = true;
                  };
                };
                documentation = {
                  auto_show = true;
                };
              };
              keymap = {
                preset = "super-tab";
              };
              signature = {
                enabled = true;
              };

            };
          };

          lsp-format = {
            enable = true;

          };

          lsp = {
            enable = true;
            inlayHints = true;
            luaConfig.content = ''
              local _border = "rounded"

                  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                    vim.lsp.handlers.hover, {
                      border = _border
                    }
                  )

                  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                    vim.lsp.handlers.signature_help, {
                      border = _border
                    }
                  )

                  vim.diagnostic.config{
                    float={border=_border}
                  };

                  require('lspconfig.ui.windows').default_options = {
                    border = _border
                  }

                  config = function(_, opts)
                    local lspconfig = require('lspconfig')
                    for server, config in pairs(opts.servers) do
                      -- passing config.capabilities to blink.cmp merges with the capabilities in your
                      -- `opts[server].capabilities, if you've defined it
                      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                      lspconfig[server].setup(config)
                    end
                  end;
            '';

            servers = {

              nixd = {
                enable = true;
                autostart = true;
                settings = 
                let
                    flake = ''(builtins.getFlake("github:vyudaa/valix")'';
                in
                {
                    nixpkgs.expr = "${flake}.nixosConfigurations.istari.options";
                };
              };
            };

          };
        };
      };
    };
}
