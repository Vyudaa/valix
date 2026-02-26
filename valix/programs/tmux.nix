{
  flake.homeModules.tmux =
    { pkgs, ... }:
    {
      programs.tmux = {
        enable = true;

        clock24 = true;
        plugins = with pkgs.tmuxPlugins; [
          sensible
        ];

        extraConfig = ''
                      
          set -g prefix C-a
          unbind C-b
          bind C-a send-prefix


        '';

      };
    };

}
