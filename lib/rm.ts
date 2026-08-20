import { shell } from "./shell.ts"

export function rm(files: string[]) {
  return shell([`rm -rf ${files.join(" ")}`])
}
