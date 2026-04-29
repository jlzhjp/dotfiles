{ config, ... }:

{
  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/.config/home-manager";
  };
}
