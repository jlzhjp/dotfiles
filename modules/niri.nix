{ pkgs, ... }:

{
  home.packages = [
    pkgs.awww
    pkgs.brightnessctl
    pkgs.fuzzel
    pkgs.ironbar
    pkgs.mako
    pkgs.playerctl
    pkgs.swayidle
    pkgs.swaylock
  ];

  xdg.configFile = {
    "awww/slideshow.sh" = {
      source = ../config/awww/slideshow.sh;
      executable = true;
    };
    "fuzzel/fuzzel.ini".source = ../config/fuzzel/fuzzel.ini;
    "ironbar/config.json".source = ../config/ironbar/config.json;
    "ironbar/style.css".source = ../config/ironbar/style.css;
    "mako/config".source = ../config/mako/config;
    "niri/config.kdl" = {
      source = ../config/niri/config.kdl;
      force = true;
    };
    "swaylock/config".source = ../config/swaylock/config;
  };
}
