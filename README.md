# eda-osic-tools

image:https://github.com/tum-ei-eda/eda-osic-tools/actions/workflows/container.yml/badge.svg?branch=main["Container", link="https://github.com/tum-ei-eda/eda-osic-tools/actions/workflows/container.yml"]
image:https://img.shields.io/github/license/tum-ei-eda/eda-osic-tools["License", link="LICENSE"]
image:https://img.shields.io/docker/v/tumeda/eda-osic-tools-deps/latest-default-ubuntu-latest["tumeda/eda-osic-tools-deps", link="https://img.shields.io/docker/v/tumeda/eda-osic-tools-deps/latest-default-ubuntu-latest"] (https://hub.docker.com/r/tumeda/eda-osic-tools-deps/tags[`DockerHub eda-osic-tools-deps`] )

Builds a Docker image with the `eda-osic-tools` environment and OpenROAD Flow Scripts (ORFS), Open-PDKs, etc.

## Requirements

- Docker with Buildx
- Free disk space on the Docker host

## Configuration

Defaults live in [`.env`](eda-osic-tools/.env):

- `workspace_dir=/eda-osic-tools`
- `ENV_VENV_ROOT=/venv`
- `ENV_ORFS_ROOT=/orfs`
- `ENV_YOSYS_EXE=/orfs/dependencies/bin/yosys`

## Build

```bash
docker buildx build . -f dockerfile \
  --no-cache \
  --progress=plain \
  --tag tum-ei-eda/eda-osic-tools:latest-default-ubuntu-latest \
  --target eda-osic-tools-deps \
  --build-arg BASE_IMAGE=ubuntu:latest \
  --build-arg workspace_dir=/eda-osic-tools \
  --build-arg ENV_VENV_ROOT=/venv
```

## Compose

```bash
docker-compose --env-file .env up --build
```

