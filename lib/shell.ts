export function shell(commands: string[]): Promise<string> {
  return Promise.resolve(`RUN ${commands.join(" \\\n    && ")}`)
}
