{ pkgs, ... }:

let
  nvimConfig = pkgs.runCommand "nvim-config" { nativeBuildInputs = [ pkgs.luaPackages.fennel ]; } ''
    cp -R ${./dot_config/nvim}/. "$out"
    chmod -R u+w "$out"
    rm -rf "$out/lua"

    fennel \
      --add-fennel-path "$out/fnl/?.fnl" \
      --add-fennel-path "$out/fnl/?/init.fnl" \
      --compile "$out/fnl/init.fnl" \
      > "$out/init.lua"
  '';
in
{
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

  xdg.configFile = {
    nvim = {
      source = nvimConfig;
      force = true;
    };
    "tmux/tmux.conf" = {
      source = ./dot_config/tmux/tmux.conf;
      force = true;
    };
  };

  programs.home-manager.enable = true;
}
