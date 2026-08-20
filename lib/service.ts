import { shell } from "./shell.ts"

export function services(names: string[]): Promise<string> {
  return shell([`systemctl --root=/ enable ${names.join(" ")}`])
}
