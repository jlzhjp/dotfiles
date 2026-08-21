function shellQuote(s: string): string {
  return `'${s.replaceAll("'", `'"'"'`)}'`
}

export function file(filename: string, content: string): Promise<string> {
  const trimmedContent = shellQuote(content.trim() + "\n")
  return Promise.resolve(
    `printf %s ${trimmedContent} > ${shellQuote(filename)}`,
  )
}
