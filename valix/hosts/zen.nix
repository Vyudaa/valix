{ inputs, ... }:
{
  flake.homeModules.zen =
    { pkgs, ... }:
    {
      programs.zen-browser = {
        suppressXdgMigrationWarning = true;
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
        profiles.mithrandir = {
          id = 0;
          name = "mithrandir";
          isDefault = true;

          extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
            bitwarden
            darkreader
            ublock-origin
          ];
        };
      };

    };
}
