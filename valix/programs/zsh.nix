{
  flake.homeModules.zsh = {

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ll = "ls -l";

        # nix related aliases

        nrs = "sudo nixos-rebuild switch --flake /etc/valix#istari";
        hms = "home-manager switch --flake /etc/valix#mithrandir";

      };

    };
  };

}
