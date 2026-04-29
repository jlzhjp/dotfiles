{
  programs.git = {
    enable = true;
    settings = {
      core.pager = "bat";
      delta.navigate = true;
      interactive.diffFilter = "delta --color-only";
      pager = {
        diff = "delta";
        log = "delta";
        reflog = "delta";
        show = "delta";
      };
      user = {
        name = "akari";
        email = "jvjdev@gmail.com";
      };
    };
  };
}
