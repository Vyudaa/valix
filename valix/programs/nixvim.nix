{ self, ... }:
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
        diagnostic.settings = {
          update_in_insert = true;
        };
        globals = {
          mapleader = " ";
          maplocalleader = "\\";
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
          conceallevel = 1;
          scrolloff = 8;
          cursorline = true;
          cursorlineopt = "number";
          termguicolors = true;
          wrap = false;
          tabstop = 4;
          softtabstop = 4;
          shiftwidth = 4;
          expandtab = true;
          autoindent = true;
        };

        keymaps = [
          {
            mode = [ "n" ];
            key = "<C-o>n";
            action = ":Obsidian new_from_template";

            options = {
              silent = true;
            };
          }
          {
            mode = [ "n" ];
            key = "<C-i>u";
            action = ":read!uuidgen<CR>";
            options = {
              silent = true;
            };
          }

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
            settings = {
              background = "hard";
              transparent_background = 2;
            };

          };
        };

        #TODO: Create modules for individual plugins
        extraPlugins = with pkgs.vimPlugins; [

          yuck-vim
          blink-pairs # does not work through nixvim
        ];

        plugins = {
          vimtex = {

            enable = true;
            texlivePackage = pkgs.texlive.combined.scheme-full;
            settings = {
              view_method = "zathura";
            };
          };
          nvim-autopairs = {
            enable = true;
          };
          fidget = {
            enable = true;
          };
          undotree = {
            enable = true;
          };

          treesitter = {
            enable = true;

            grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
              nix
              vim
              yuck
            ];
            settings = {
              indent.enable = true;
              highlight.enable = true;
            };

          };
          obsidian = {
            enable = true;
            settings = {
              legacy_commands = false;

              templates = {
                folder = "templates";
              };

              workspaces = [
                {
                  name = "Istya";
                  path = "~/vaults/Istya";
                }
              ];
            };
          };
          fzf-lua = {
            enable = true;
            keymaps = {
              "<leader>ff" = "files";
              "<leader>fw" = "grep";
              "<leader>fg" = "global";
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
                    # The wrapper curries `_nixd-expr.nix` with the `self` and `system` args
                    # This makes `init.lua` a bit DRYer and more readable
                    wrapper = builtins.toFile "expr.nix" ''
                      import ${./_nixd_expr.nix} {
                        self = ${builtins.toJSON self};
                        system = ${builtins.toJSON pkgs.stdenv.hostPlatform.system};
                      }
                    '';
                    # withFlakes brings `local` and `global` flakes into scope, then applies `expr`
                    withFlakes = expr: "with import ${wrapper}; " + expr;
                  in
                  {
                    nixpkgs.expr = withFlakes ''
                      import (if local ? lib.version then local else local.inputs.nixpkgs or global.inputs.nixpkgs) { }
                    '';

                    formatting.command = [ "nixfmt" ];
                    options = {
                      flake-parts.expr = withFlakes "local.debug.options or global.debug.options";
                      nixos.expr = withFlakes "global.nixosConfigurations.istari.options";
                      home-manager.expr = withFlakes "global.homeConfigurations.mithrandir.options";
                      nixvim.expr = withFlakes ''global.homeConfigurations.mithrandir.options.programs.nixvim.type.getSubOptions [ "programs" "nixvim"]'';
                    };
                  };
              };
            };

          };
        };
      };
    };
}
