export function dnf(packages: string[]): Promise<string> {
  return Promise.resolve(`RUN dnf install -y ${packages.join(" ")}`)
}
