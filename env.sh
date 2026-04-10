#!/usr/bin/env bash

source_env() {
  env_file="$1"
  echo "[source_env] from file ${env_file}"

  while IFS='=' read -r key value; do
    [[ -z "$key" || "$key" =~ ^# ]] && continue
    key=${key#ENV_}
    value_expanded=$(eval echo "$value")
    export "$key=$value_expanded"
    echo "$key=$value_expanded"
  done < ${env_file}
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

__env_file__="$1"
echo -n "[env] ..."
source_env "${__env_file__}" && source_venv
echo -n "[env] done."
