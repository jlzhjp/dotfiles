default: verify

verify: format lint

update:
    nix flake update

format:
    find . -name '*.nix' -print0 | xargs -0 nixfmt
    find akari/config/nvim -name '*.fnl' -print0 | xargs -0 fnlfmt --fix

lint:
    statix check .
    deadnix .
    fennel --add-fennel-path akari/config/nvim/?.fnl --add-fennel-path akari/config/nvim/?/init.fnl --compile akari/config/nvim/init.fnl > /tmp/home-manager-nvim-init.lua
