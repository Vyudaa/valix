{
    flake.homeModules.git = {

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "vyudaa";
        email = "natevance01@gmail.com";
      };
      init.defaultbranch = "main";
      alias = {
        gs = "git status";
        gsw = "git switch";
      };
    };
  };
    };
}
