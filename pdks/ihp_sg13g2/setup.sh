#!/usr/bin/env bash
__what__="ihp-sg13g2"
__detail__="IHP GmbH's 130nm BiCmos Open-PDK"

setup_apt() {
  echo "[setup apt] ${__what__} ..."

  general_apt_dep="" # sudo requried because orfs scripts hard coded for it...
  apt update && \
    apt install --no-install-recommends -y ${general_apt_dep}
  status=$?

  echo "[setup apt] ${__what__} done."
  return "${status}"
}

fetch() {
  echo "[fetch] ${__what__} ..."

  src_dir="$1"
  url="https://github.com/IHP-GmbH/IHP-Open-PDK.git"
  ref="v0.3.0"
  __home__="${PWD}"
  git clone --branch "${ref}" --single-branch "${url}" "${src_dir}" --progress && \
    cd "${src_dir}" && \
    rm -rf .git/ && \
    cd "${__home__}"
  status=$?

  echo "[fetch] ${__what__} done."
  return "${status}"
}

install() {
  echo "[install] ${__what__} ..."

  src_dir="$1"
  cd "${src_dir}"
  python3 -m pip install -r "requirements.txt"
  status=$?

  echo "[install] ${__what__} done."
  return "${status}"
}

__root__="$1"
mkdir -p "${__root__}"
echo -n "[setup] ${__detail__} (${__what__}) at '${__root__}'"
setup_apt &&  fetch "${__root__}" && install "${__root__}"
status=$?
echo -n "[setup] ${__detail__} (${__what__}) at '${__root__}' done."
return "${status}" 2>/dev/null || exit "${status}"
