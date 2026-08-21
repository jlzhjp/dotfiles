build:
    deno task gen
    sudo podman build --network=host ./build -t localhost/fedora-system

switch: build
    sudo bootc switch --transport containers-storage localhost/fedora-system
