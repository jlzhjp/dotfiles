default: all

all: format lint

format:
    nixfmt flake.nix home.nix
    fnlfmt --fix dot_config/nvim/fnl/init.fnl dot_config/nvim/fnl/config/*.fnl

lint:
    statix check .
    deadnix .
    fennel --add-fennel-path dot_config/nvim/fnl/?.fnl --add-fennel-path dot_config/nvim/fnl/?/init.fnl --compile dot_config/nvim/fnl/init.fnl > /tmp/home-manager-nvim-init.lua
