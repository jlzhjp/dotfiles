export function dnf(packages: string[]): Promise<string> {
  return Promise.resolve(
    `RUN dnf -y install ${
      packages.map((p) => `"${p}"`).join(" ")
    } && dnf clean all`,
  )
}
