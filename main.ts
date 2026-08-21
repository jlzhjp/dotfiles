import * as path from "@std/path"

import { getWorkdir } from "./lib/env.ts"

import { from } from "./lib/image.ts"
import { run } from "./lib/shell.ts"

import {
  dnfClean,
  dnfCommand,
  dnfCoprs,
  dnfInstall,
  dnfRepos,
} from "./lib/cmd/dnf.ts"
import { rm } from "./lib/cmd/rm.ts"
import { file } from "./lib/cmd/file.ts"

import { dnfPackages } from "./dnf-packages.ts"

const image = await Promise.all([
  from("quay.io/fedora/fedora-silverblue", "44", {}),

  run([
    "if [ -L /opt ]; then rm /opt; fi",
    "mkdir -p /opt",
  ]),

  run([
    dnfRepos([
      "https://pkgs.tailscale.com/stable/fedora/tailscale.repo",
      "https://download.docker.com/linux/fedora/docker-ce.repo",
    ]),
    dnfCoprs([
      "scottames/ghostty",
      "alternateved/keyd",
    ]),
    dnfInstall([
      "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm",
      "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm",
    ]),

    dnfCommand("swap ffmpeg-free ffmpeg --allowerasing"),
    dnfInstall([
      ...Object.values(dnfPackages).flat(),
      "https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm",
      "https://update.code.visualstudio.com/latest/linux-rpm-x64/stable",
      "https://persistent.oaistatic.com/codex-app-prod/linux/rpm/latest/chatgpt.x86_64.rpm",
      "https://bitwarden.com/download/?app=desktop&platform=linux&variant=rpm",
    ]),

    dnfClean(),

    rm([
      "/run/dnf",
      "/var/cache/dnf",
      "/var/cache/ibus",
      "/var/cache/ldconfig",
      "/var/cache/libdnf5",
      "/var/cache/tailscale",
      "/var/lib/dnf",
      "/var/log/dnf5.log*",
      "/tmp/nvim.root",
    ]),
  ]),

  run([
    "sed -i '/^docker:/d' /etc/group",
    file("/usr/lib/sysusers.d/docker.conf", "g docker -"),
    file(
      "/usr/lib/tmpfiles.d/tailscale.conf",
      "d /var/cache/tailscale 0755 root root -",
    ),
  ]),

  run([
    file(
      "/etc/keyd/default.conf",
      `[ids]
*

[main]
capslock = overload(control, esc)
esc = capslock`,
    ),
  ]),

  run(["bootc container lint"]),
])

const workdir = await getWorkdir()
const containerFile = path.join(workdir, "Containerfile")
Deno.writeTextFile(containerFile, image.join("\n"))
