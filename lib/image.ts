export function from(
  image: string,
  tag: string,
  { alias }: { alias?: string },
): Promise<string> {
  const aliasPart = alias ? ` AS ${alias}` : ""
  return Promise.resolve(`FROM ${image}:${tag}${aliasPart}`)
}
