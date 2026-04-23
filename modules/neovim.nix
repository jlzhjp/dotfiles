{ pkgs, ... }:

let
  source = ../config/nvim;
  nvimConfig = pkgs.runCommand "nvim-config" { nativeBuildInputs = [ pkgs.luaPackages.fennel ]; } ''
    cp -R ${source}/. "$out"
    chmod -R u+w "$out"

    fennel \
      --add-fennel-path "$out/?.fnl" \
      --add-fennel-path "$out/?/init.fnl" \
      --compile "$out/init.fnl" \
      > "$out/init.lua"
  '';
in
{
  xdg.configFile.nvim.source = nvimConfig;
}
