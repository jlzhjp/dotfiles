{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./modules/fish.nix
    ./modules/neovim.nix
    ./modules/starship.nix
    ./modules/tmux.nix
  ];

  home = {
    username = "akari";
    homeDirectory = "/var/home/akari";
    stateVersion = "25.11";

    packages = [
      pkgs.bat
      pkgs.bun
      inputs.codex-cli-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.deadnix
      pkgs.fennel-ls
      pkgs.fnlfmt
      pkgs.harper
      pkgs.just
      pkgs.luaPackages.fennel
      pkgs.nixfmt
      pkgs.nodejs
      pkgs.pnpm
      pkgs.ripgrep
      pkgs.rustup
      pkgs.statix
      pkgs.tree-sitter
      pkgs.uv
    ];

    sessionPath = [
      "${config.home.profileDirectory}/bin"
    ];
  };

  programs.home-manager.enable = true;
}
