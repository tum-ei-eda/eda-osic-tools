# eda-osic-tools

[![Container](https://github.com/tum-ei-eda/eda-osic-tools/actions/workflows/container.yml/badge.svg?branch=main)](https://github.com/tum-ei-eda/eda-osic-tools/actions/workflows/container.yml)
[![License](https://img.shields.io/github/license/tum-ei-eda/eda-osic-tools)](LICENSE)
[![Docker Image](https://img.shields.io/docker/v/tumeda/eda-osic-tools/latest-default-ubuntu-latest)](https://hub.docker.com/r/tumeda/eda-osic-tools/tags)

Builds a Docker image with the `eda-osic-tools` environment and OpenROAD Flow Scripts (ORFS), Open-PDKs, etc.

## Configuration

Defaults live in [`.env`](.env):

- `workspace_dir=/eda-osic-tools`
- `ENV_VENV_ROOT=/venv`
- `ENV_ORFS_ROOT=/orfs`
- `ENV_YOSYS_EXE=/orfs/dependencies/bin/yosys`

## Build

### Requirements

- Docker with Buildx, or
- Docker with compose, or
- Free disk space on the Docker host

### Buildx

```bash
docker buildx build . -f dockerfile \
  --no-cache \
  --progress=plain \
  --tag tum-ei-eda/eda-osic-tools:latest-default-ubuntu-latest \
  --target eda-osic-tools \
  --build-arg BASE_IMAGE=ubuntu:latest \
  --build-arg workspace_dir=/eda-osic-tools \
  --build-arg ENV_VENV_ROOT=/venv
```

### Compose

```bash
docker-compose --env-file .env up --build
```

## Prebuilt

### Pull

```bash
docker pull tumeda/eda-osic-tools:latest-default-ubuntu-latest
```

### Launch

Run an interactive shell with the current checkout mounted into the default workspace:

```bash
docker run --rm -it \
  -v "$(pwd)":/your-workspace \
  -w /your-workspace \
  tumeda/eda-osic-tools:latest-default-ubuntu-latest \
  bash
```

Inside the container, load the default environment from the copied `/eda-osic-tools`:

```bash
. /eda-osic-tools/env.sh /eda-osic-tools/.env
```
