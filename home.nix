{ pkgs, ... }:

{
  imports = [
    ./modules/neovim.nix
    ./modules/tmux.nix
  ];

  home = {
    username = "akari";
    homeDirectory = "/var/home/akari";
    stateVersion = "25.11";

    packages = [
      pkgs.deadnix
      pkgs.fennel-ls
      pkgs.fnlfmt
      pkgs.just
      pkgs.luaPackages.fennel
      pkgs.nixfmt
      pkgs.statix
    ];
  };

  programs.home-manager.enable = true;
}
