build:
    deno task gen
    podman build ./build -t localhost/fedora-system