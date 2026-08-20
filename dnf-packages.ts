export const dnfPackages = {
  system: [
    "git",
    "distrobox",
    "systemd-homed",
  ],
  terminal: [
    "ghostty",
    "neovim",
    "fish",
    "tmux",
  ],
  cryptography: [
    "age",
    "sops",
    "openssl",
  ],
  docker: [
    "docker-ce",
    "docker-ce-cli",
    "containerd.io",
    "docker-buildx-plugin",
    "docker-compose-plugin",
  ],
  network: [
    "aria2",
    "rclone",
    "tailscale",
  ],
  cli: [
    "bat",
    "ripgrep",
    "btop",
    "fd-find",
    "jq",
    "yq",
    "wl-clipboard",
    "direnv",
    "eza",
    "fzf",
    "starship",
    "zoxide",
    "psmisc", // pstree, killall, fuser, pslog
    "lsof",
    "fastfetch",
    "mosh",
  ],
  cloudNative: [
    "kubernetes-client",
    "helm",
  ],
  cpp: [
    "clang",
    "clang-tools-extra",
    "cmake",
  ],
  database: [
    "duckdb",
    "sqlite",
  ],
}
