# Nix Zig example

Example on how to use nix to setup reproducible dev environments.

## Required

- nix: main build toolchain
- direnv: to automate the setup of the dev environment

> Note the absence of zig toolchain in required dependancies as they are handled by nix

## Commands

### Build

```sh
nix build
```

### Run

```sh
nix run
```

### Build docker container

```sh
nix build .#docker
docker load < result
```

### Get shell with access to all needed tools

> automated by direnv

```sh
nix develop
```
