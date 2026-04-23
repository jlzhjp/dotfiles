# AGENTS.md

## Working Rules

- This repository is a Nix Home Manager configuration for user `akari`.
- Ask for elevated approval before running `nix`, `home-manager`, or other commands that need to escape the sandbox.
- Do not reintroduce Neovim runtime Fennel compilation. Home Manager builds `dot_config/nvim/fnl/init.fnl` into the installed Neovim `init.lua`.
- Keep generated files out of the source tree unless the user explicitly asks otherwise.
- Do not revert user changes or unrelated work in this repository.

## Formatting And Checks

After editing, run the full formatter and linter workflow:

```sh
just
```

Use `just format` for formatting only and `just lint` for checks only.

Use elevated approval for Nix/Home Manager commands, including `home-manager switch --flake .#akari`. If the `just` package is not installed yet, switch Home Manager first or run the commands from `justfile` directly.
