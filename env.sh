#!/usr/bin/env bash

source_env() {
  env_file="$1"
  echo "[source_env] from file ${env_file}"

  while IFS='=' read -r key value; do
    [ -z "$key" ] && continue
    case "$key" in
      \#*) continue
    esac
    key=${key#ENV_}
    value_expanded=$(eval echo "$value")
    export "$key=$value_expanded"
    echo "$key=$value_expanded"
  done < "${env_file}"
  status=$?

  echo "[source_env] from file ${env_file} done."
  return ${status}
}

source_venv() {
  echo "[source_venv] from dir ${VENV_ROOT}"

  test -f "${VENV_ROOT}/bin/activate" && \
    . "${VENV_ROOT}/bin/activate"
  status=$?

  echo "[source_venv] from dir ${VENV_ROOT} done."
  return ${status}
}

if [ -n "$1" ]; then
  __env_file__="$1"
else
  if [ -f "/eda-osic-tools/.env" ]; then
    __env_file__="/eda-osic-tools/.env"
  elif [ -n "${BASH_SOURCE:-}" ]; then
    SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE}")" && pwd)
    __env_file__="${SCRIPT_DIR}/.env"
  else
    __env_file__="$(pwd)/.env"
  fi
fi
echo -n "[env] ..."
source_env "${__env_file__}" && source_venv
echo -n "[env] done."
