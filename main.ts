import * as path from "@std/path"

import { getWorkdir } from "./lib/env.ts"
import { dnf } from "./lib/dnf.ts"
import { from } from "./lib/image.ts"
import { dnfPackages } from "./dnf-packages.ts"
import { repos } from "./lib/repo.ts"
import { services } from "./lib/service.ts"
import { coprs } from "./lib/copr.ts"
import { rm } from "./lib/rm.ts"
import { shell } from "./lib/shell.ts"

const image = await Promise.all([
  from("quay.io/fedora/fedora-silverblue", "44", {}),

  repos([
    "https://pkgs.tailscale.com/stable/fedora/tailscale.repo",
    "https://download.docker.com/linux/fedora/docker-ce.repo",
  ]),
  coprs([
    "scottames/ghostty",
  ]),
  dnf([
    "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm",
    "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm",
  ]),
  dnf([
    ...Object.values(dnfPackages).flat(),
    "https://persistent.oaistatic.com/codex-app-prod/linux/rpm/latest/chatgpt.x86_64.rpm",
  ]),
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
  services([
    "systemd-homed.service",
    "systemd-homed-firstboot.service",
  ]),

  shell([
    "sed -i '/^docker:/d' /etc/group",
    "printf '%s\\n' 'g docker -' >/usr/lib/sysusers.d/docker.conf",
    "printf '%s\\n' 'd /var/cache/tailscale 0755 root root -' >/usr/lib/tmpfiles.d/tailscale.conf",
  ]),

  shell(["bootc container lint"]),
])

const workdir = await getWorkdir()
const containerfile = path.join(workdir, "Containerfile")
Deno.writeTextFile(containerfile, image.join("\n"))
