default: all

all: format lint

format:
    nixfmt flake.nix home.nix modules/*.nix
    fnlfmt --fix config/nvim/*.fnl

lint:
    statix check .
    deadnix .
    fennel --add-fennel-path config/nvim/?.fnl --add-fennel-path config/nvim/?/init.fnl --compile config/nvim/init.fnl > /tmp/home-manager-nvim-init.lua
