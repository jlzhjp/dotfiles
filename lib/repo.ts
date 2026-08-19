import { getWorkdir } from "./env.ts"
import * as path from "@std/path"

export default async function repos(urls: string[]): Promise<string> {
  const workdir = await getWorkdir()
  const repoDir = "repos"
  await Deno.mkdir(path.join(workdir, repoDir))

  const repoFiles = await Promise.all(
    urls.map((url) => downloadRepo(url, repoDir)),
  )

  return `COPY ${repoFiles.join(" ")} /etc/yum.repos.d/`
}

async function downloadRepo(url: string, dir: string): Promise<string> {
  const workdir = await getWorkdir()
  const repoPath = path.join(workdir, dir)

  const urlObject = new URL(url)
  const repoFilename = path.basename(urlObject.pathname)

  const res = await fetch(url)

  if (!res.ok || !res.body) {
    throw new Error(`Download failed: ${res.status}`)
  }

  const file = await Deno.open(path.join(repoPath, repoFilename), {
    write: true,
    create: true,
    truncate: true,
  })

  await res.body.pipeTo(file.writable)

  return path.join(dir, repoFilename)
}
