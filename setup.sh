#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
__what__="eda-osic-tools"
__detail__="eda@tum open-source tools layer"

venv_dir="$1"
workspace_dir="$2"

setup_apt() {
  echo "[setup apt] ${__what__} ..."
  general_apt_dep="git grep wget tar python3 python3-virtualenv python3-dev python3-venv python3-pip vim graphviz"
  apt update && \
    apt install --no-install-recommends -y ${general_apt_dep}
  status=$?
  echo "[setup apt] ${__what__} done."
  return "${status}"
}

setup_venv() {
  echo "[setup venv] ${__what__} ..."

  venv_dir="$1"
  workspace_dir="$2"
  python3 -m venv "${venv_dir}" && \
    test -f "${venv_dir}/bin/activate"
  status=$?

  echo "[setup venv] ${__what__} done."
  return "${status}"
}

echo -n "[setup] ${__detail__} (${__what__})"
setup_apt && setup_venv "${venv_dir}" "${workspace_dir}"
status=$?
echo -n "[setup] ${__detail__} (${__what__}) done."
return "${status}" 2>/dev/null || exit "${status}"
