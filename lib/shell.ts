type Command = Promise<string> | Promise<string[]> | string | string[]

export async function shell(commands: Command[]): Promise<string> {
  return "RUN " +
    (await Promise.all(commands)).flatMap((cmd) =>
      Array.isArray(cmd) ? cmd : [cmd]
    ).join("\\\n && ")
}
