{ inputs, ... }:
{
  flake.homeModules.zen =
    { pkgs, ... }:
    {
      programs.zen-browser = {
        suppressXdgMigrationWarning = true;
        nativeMessagingHosts = [ pkgs.firefoxpwa ];
        enable = true;
        policies = {
          AutofillAddressEnabled = true;
          AutofillCreditCardEnabled = false;
          DisableAppUpdate = true;
          DisableFeedbackCommands = true;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DontCheckDefaultBrowser = true;
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          DownloadDirectory = "home/mithrandir/downloads"; # change this, should come for top-level option

        };
        #TODO: fix with let ... in
        profiles.mithrandir = rec {
          id = 0;
          name = "mithrandir";
          isDefault = true;

          mods = [
            "253a3a74-0cc4-47b7-8b82-996a64f030d5" # Floating History
            "c6813222-6571-4ba6-8faf-58f3343324f6" # No Rounded Corners
            "a6335949-4465-4b71-926c-4a52d34bc9c0" # Better find bar
            "f7c71d9a-bce2-420f-ae44-a64bd92975ab" # Better Unloaded Tabs
            "906c6915-5677-48ff-9bfc-096a02a72379" # Floating Status Bar
            "c8d9e6e6-e702-4e15-8972-3596e57cf398" # Remove Back Forward
            "253a3a74-0cc4-47b7-8b82-996a64f030d5" # Floating History
            "e122b5d9-d385-4bf8-9971-e137809097d0" # No Top Sites

            "cb15abdb-0514-4e09-8ce5-722cf1f4a20f" # Hide Extension Name
            "d8b79d4a-6cba-4495-9ff6-d6d30b0e94fe" # Better Active Tab

          ];
          userChrome = ''



                :root {
                    --zen-colors-primary: #1e2326 !important; /* Background */
                    --zen-primary-color: #a7c080 !important; /* Primary */
                    --zen-colors-secondary: #2b3339 !important; /* Secondary */
                    --zen-colors-tertiary: #272e33 !important; /* Tertiary */
                    --zen-colors-border: #3c4841 !important; /* Border */
                    --toolbarbutton-icon-fill: #d3c6aa !important; /* Icon Fill */
                    --lwt-text-color: #d3c6aa !important; /* Text Color */
                    --toolbar-field-color: #d3c6aa !important; /* Field Color */
                    --tab-selected-textcolor: rgb(167, 192, 128) !important; /* Selected Tab Text Color */
                    --toolbar-field-focus-color: #d3c6aa !important; /* Focus Field Color */
                    --toolbar-color: #d3c6aa !important; /* Toolbar Color */
                    --newtab-text-primary-color: #d3c6aa !important; /* New Tab Text Primary Color */
                    --arrowpanel-color: #d3c6aa !important; /* Arrow Panel Color */
                    --arrowpanel-background: #2e383c !important; /* Arrow Panel Background */
                    --sidebar-text-color: #d3c6aa !important; /* Sidebar Text Color */
                    --lwt-sidebar-text-color: #d3c6aa !important; /* Sidebar Text Color (LWT) */
                    --lwt-sidebar-background-color: #272e33 !important; /* Sidebar Background (LWT) */
                    --toolbar-bgcolor: #2b3339 !important; /* Toolbar Background Color */
                    --newtab-background-color: #1e2326 !important; /* New Tab Background Color */
                    --zen-themed-toolbar-bg: #1e2326 !important; /* Themed Toolbar Background */
                }

                .toolbarbutton-1[open="true"] .toolbarbutton-icon {
                    fill: #4c566a !important; /* Dark foreground color from Everforest */
                }
                
                #permissions-granted-icon {
                    fill : var(--zen-themed-toolbar-bg) !important;
                }
                
                #zen-workspaces-button {
                    background-color: var(--zen-colors-primary) !important;
                }
          '';

          settings = {
            "browser.search.region" = "US";
            "browser.search.isUS" = true;
            "distribution.searchplugins.defaultLocale" = "en-US";
            "general.useragent.locale" = "en-US";

            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            # Disable swipe gestures
            "browser.gesture.swipe.left" = "";
            "browser.gesture.swipe.right" = "";
          };
          keyboardShortcuts = [
            {
              id = "zen-workspace-forward";
              key = "]";
              modifiers = {
                control = true;
                alt = false;
              };
            }

            {
              id = "zen-workspace-backward";
              key = "[";
              modifiers = {
                control = true;
                alt = false;
              };
            }
          ];

          extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
            bitwarden
            darkreader
            ublock-origin
            refined-github
          ];
          containers = {
            study = {
              color = "blue";
              icon = "circle";
              id = 1;
            };
            dev = {
              color = "green";
              icon = "tree";
              id = 2;
            };
          };

          spacesForce = true;
          spaces = {
            "study" = {
              id = "5a561d74-4b49-4013-bf24-10c39a56d88b";
              position = 1000;
            };

            "dev" = {
              position = 1001;
              id = "5a561d74-4b49-4113-af24-10c39a56d88b";
            };
          };
          search = {
            force = true;
            default = "ddg";
            engines = {
              nix-packages = {
                name = "Nix Packages";
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };

              nixos-wiki = {
                name = "NixOS Wiki";
                urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
                iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
                definedAliases = [ "@nw" ];
              };

              mynixos = {
                name = "My NixOS";
                urls = [
                  {
                    template = "https://mynixos.com/search?q={searchTerms}";
                    params = [
                      {
                        name = "query";
                        value = "searchTerms";
                      }
                    ];
                  }
                ];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@nx" ]; # Keep in mind that aliases defined here only work if they start with "@"
              };
            };

          };
          pinsForce = true;
          pins = {
            "Github" = {
              id = "48e8a119-5a14-4826-9545-91c8e8dd3bf6";
              workspace = spaces."dev".id;
              url = "https://github.com";
              position = 101;
              isEssential = false;
            };
            "Gmail" = {
              id = "3352f497-a5f0-42e8-8dda-6f780d94d96d";
              workspace = spaces."study".id;
              url = "https://gmail.com";
              position = 101;
              isEssential = false;
            };

            "d2l" = {
              id = "4bfbcbbf-01d9-4d58-8d72-5623d42c8633";
              workspace = spaces."study".id;
              url = "https://normandale.learn.minnstate.edu/d2l/login";
              position = 102;
              isEssential = false;
            };
          };
        };
      };
    };
}
