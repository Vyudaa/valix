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

          settings = {
            "browser.search.region" = "US";
            "browser.search.isUS" = true;
            "distribution.searchplugins.defaultLocale" = "en-US";
            "general.useragent.locale" = "en-US";

            # Disable swipe gestures
            "browser.gesture.swipe.left" = "";
            "browser.gesture.swipe.right" = "";
          };

          extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
            bitwarden
            darkreader
            ublock-origin
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
