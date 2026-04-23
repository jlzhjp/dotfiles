# AGENTS.md

## Working Rules

- This repository is a Nix Home Manager configuration for user `akari`.
- Ask for elevated approval before running `nix`, `home-manager`, or other commands that need to escape the sandbox.
- Do not reintroduce Neovim runtime Fennel compilation. Home Manager builds `config/nvim/init.fnl` into the installed Neovim `init.lua`.
- Do not manage `~/.config/nvim` as one immutable directory. Manage only the generated `nvim/init.lua` file so `vim.pack` can create its untracked lockfile in the writable config directory.
- Keep user-facing Home Manager code in modules under `modules/`; keep application source files under `config/`.
- Keep generated files out of the source tree unless the user explicitly asks otherwise.
- Do not revert user changes or unrelated work in this repository.

## Formatting And Checks

After editing, run the full formatter and linter workflow:

```sh
just
```

Use `just format` for formatting only and `just lint` for checks only.

Use elevated approval for Nix/Home Manager commands, including `home-manager switch --flake .#akari`. If the `just` package is not installed yet, switch Home Manager first or run the commands from `justfile` directly.
