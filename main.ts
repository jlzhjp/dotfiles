import { dnf } from "./lib/dnf.ts"
import { from } from "./lib/image.ts"

import { dnfPackages } from "./dnf-packages.ts"
import repos from "./lib/repo.ts"

const image = await Promise.all([
  from("quay.io/fedora/fedora-silverblue", "44", {}),

  repos([
    "https://pkgs.tailscale.com/stable/fedora/tailscale.repo",
  ]),
  dnf(Object.values(dnfPackages).flat()),
])

console.log(image.join("\n"))
