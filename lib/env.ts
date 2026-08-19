export async function getWorkdir(): Promise<string> {
  const workdir = "./build"
  await Deno.mkdir(workdir, { recursive: true })
  return workdir
}
