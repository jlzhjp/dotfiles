{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./modules/fish.nix
    ./modules/git.nix
    ./modules/neovim.nix
    ./modules/starship.nix
    ./modules/tmux.nix
  ];

  home = {
    username = "akari";
    homeDirectory = "/var/home/akari";
    stateVersion = "25.11";

    packages = [
      pkgs.actionlint
      pkgs.bat
      pkgs.bun
      inputs.codex-cli-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.deadnix
      pkgs.delta
      pkgs.fennel-ls
      pkgs.fnlfmt
      pkgs.go
      pkgs.gopls
      pkgs.gh
      pkgs.harper
      pkgs.just
      pkgs.luaPackages.fennel
      pkgs.nixd
      pkgs.nixfmt
      pkgs.nodejs
      pkgs.pnpm
      pkgs.ripgrep
      pkgs.rustup
      pkgs.statix
      pkgs.tree-sitter
      pkgs.ty
      pkgs.uv
      pkgs.yaml-language-server
    ];

    sessionPath = [
      "${config.home.profileDirectory}/bin"
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      MANPAGER = "nvim +Man!";
    };
  };

  programs.home-manager.enable = true;
}
