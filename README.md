# Home Manager Configuration

Nix Home Manager configuration for `akari`.

## Bootstrap

Install Nix first, then place this repository at Home Manager's default config
location:

```sh
mkdir -p ~/.config
git clone https://github.com/jlzhjp/dotfiles ~/.config/home-manager
cd ~/.config/home-manager
```

Apply the flake once with `nix run`. This works even before the
`home-manager` command has been installed into the user profile:

```sh
nix run github:nix-community/home-manager -- switch --flake .#akari
```

After the first switch, use the installed command:

```sh
home-manager switch --flake ~/.config/home-manager#akari
```

## Daily Use

Format and lint everything:

```sh
just
```

Run only formatting or checks:

```sh
just format
just lint
```

Update inputs and apply:

```sh
nix flake update
just
home-manager switch --flake .#akari
```

## Layout

- `home.nix` contains the user profile, packages, and shared session settings.
- `modules/` contains Home Manager modules for managed programs.
- `config/` contains application source files used by those modules.
- `config/nvim/init.fnl` is compiled by Home Manager into Neovim's `init.lua`.
