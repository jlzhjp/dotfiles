export function repos(urls: string[]): Promise<string> {
  const flags = urls.map((url) => `-O ${url}`).join(" ")
  return Promise.resolve(
    `RUN curl --parallel --output-dir  /etc/yum.repos.d/ ${flags}`,
  )
}
