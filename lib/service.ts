import { shell } from "./shell.ts"

export function service(names: string[]): Promise<string> {
  return shell([`systemctl --root=/ enable ${names.join(" ")}`])
}
