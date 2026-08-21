export function file(filename: string, content: string): Promise<string> {
  let delimiter = "EOF"

  while (content.split("\n").includes(delimiter)) {
    delimiter += "_"
  }

  return Promise.resolve(`cat > ${filename} <<'${delimiter}'
${content}
${delimiter}`)
}
