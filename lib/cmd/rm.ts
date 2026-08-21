export function rm(files: string[]): Promise<string> {
  return Promise.resolve(`rm -rf ${files.join(" ")}`)
}
