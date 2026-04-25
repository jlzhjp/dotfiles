# AGENTS.md

## Working Rules

- This repository is a Nix Home Manager configuration for user `akari`.
- Ask for elevated approval before running `nix`, `home-manager`, or other commands that need to escape the sandbox.
- Do not reintroduce Neovim runtime Fennel compilation. Home Manager builds `config/nvim/init.fnl` into the installed Neovim `init.lua`.
- Do not manage `~/.config/nvim` as one immutable directory. Manage `nvim/init.lua` (generated from `config/nvim/init.fnl`) and explicit subpaths like `nvim/queries`, while keeping the `~/.config/nvim` root writable so `vim.pack` can create its untracked lockfile there.
- Keep user-facing Home Manager code in modules under `modules/`; keep application source files under `config/`.
- Add simple CLI tools to `home.packages`; use `programs.*` modules only when configuring the program beyond installation.
- Keep generated files out of the source tree unless the user explicitly asks otherwise.
- Prefer `pkgs.stdenv.hostPlatform.system` over `pkgs.system`; `pkgs.system` emits an evaluation warning in current nixpkgs.
- Do not revert user changes or unrelated work in this repository.
- At each step, capture lessons learned and update persistent memory or this file when a new repo-specific rule would prevent repeating a mistake in future work.

## Formatting And Checks

After editing, run the full formatter and linter workflow:

```sh
just verify
```

Use `just format` for formatting only and `just lint` for checks only.

Use `just` or `just switch` to apply the Home Manager configuration.

Use elevated approval for Nix/Home Manager commands, including `just`, `just switch`, and `home-manager switch --flake .#akari`. If the `just` package is not installed yet, switch Home Manager first or run the commands from `justfile` directly.
