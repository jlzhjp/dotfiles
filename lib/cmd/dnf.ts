export function dnfCommand(command: string): Promise<string> {
  return Promise.resolve(`dnf -y ${command}`)
}

export function dnfInstall(names: string[]): Promise<string> {
  return dnfCommand(`install ${names.map((p) => `"${p}"`).join(" ")}`)
}

export function dnfClean(): Promise<string> {
  return dnfCommand("clean all")
}

export function dnfCoprs(names: string[]): Promise<string[]> {
  return Promise.all(
    names.map((name) => dnfCommand(`copr enable ${name}`)),
  )
}

export function dnfRepos(urls: string[]): Promise<string[]> {
  return Promise.all(
    urls.map((url) =>
      dnfCommand(`config-manager addrepo --from-repofile=${url}`)
    ),
  )
}
