function shellQuote(s: string): string {
  return `'${s.replaceAll("'", `'\"'\"'`)}'`
}

export function file(filename: string, content: string): Promise<string> {
  return Promise.resolve(
    `printf %s ${shellQuote(content)} > ${shellQuote(filename)}`,
  )
}
