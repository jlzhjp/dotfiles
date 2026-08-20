import { shell } from "./shell.ts"

export function coprs(names: string[]): Promise<string> {
  return shell(names.map((name) => `dnf copr enable ${name}`))
}
