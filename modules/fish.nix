{
  programs.fish = {
    enable = true;
    shellAliases = {
      diff = "diff --color=auto";
      df = "df -h";
      du = "du -h";
      grep = "grep --color=auto";
      la = "ls -A --color=auto --group-directories-first --human-readable";
      ll = "ls -l --color=auto --group-directories-first --human-readable";
      ls = "ls --color=auto --group-directories-first --human-readable";
    };
  };

  xdg.configFile."fish/config.fish".force = true;
}
