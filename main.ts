import * as path from "@std/path"

import { getWorkdir } from "./lib/env.ts"
import { dnf } from "./lib/dnf.ts"
import { from } from "./lib/image.ts"
import { dnfPackages } from "./dnf-packages.ts"
import { repos } from "./lib/repo.ts"
import { service } from "./lib/service.ts"
import { coprs } from "./lib/copr.ts"

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
    "https://bitwarden.com/download/?app=desktop&platform=linux&variant=rpm",
    "https://persistent.oaistatic.com/codex-app-prod/linux/rpm/latest/chatgpt.x86_64.rpm",
  ]),
  service([
    "systemd-homed.service",
    "systemd-homed-firstboot.service",
  ]),
])

const workdir = await getWorkdir()
const containerfile = path.join(workdir, "Containerfile")
Deno.writeTextFile(containerfile, image.join("\n"))
