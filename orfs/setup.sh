#!/usr/bin/env bash
__what__="orfs"
__detail__="OpenROAD Flow Scripts"

setup_apt() {
  echo "[setup apt] ${__what__} ..."

  general_apt_dep="git grep"
  apt update && \
    apt install --no-install-recommends -y ${general_apt_dep}
  status=$?

  echo "[setup apt] ${__what__} done."
  return "${status}"
}

fetch() {
  echo "[fetch] ${__what__} ..."

  src_dir="$1"
  url="https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts.git"
  ref="26Q2"
  __home__="${PWD}"
  git clone --branch "${ref}" --single-branch "${url}" "${src_dir}" --progress && \
    cd "${src_dir}" && \
    git submodule update --init --recursive && \
    cd "${__home__}"
  status=$?

  echo "[fetch] ${__what__} done."
  return "${status}"
}

install() {
  echo "[install] ${__what__} ..."

  src_dir="$1"
  __home__="${PWD}"
  cd "${src_dir}"
  etc/DependencyInstaller.sh -base && \
  etc/DependencyInstaller.sh -common && \
  ./build_openroad.sh -o && \
  rm -rf .git/ && \
    cd "${__home__}"
  status=$?

  echo "[install] ${__what__} done."
  return "${status}"
}

__root__="$1"
echo -n "[setup] ${__detail__} (${__what__}) at '${__root__}'"
setup_apt && fetch "${__root__}" && install "${__root__}"
status=$?
echo -n "[setup] ${__detail__} (${__what__}) at '${__root__}' done."
return "${status}" 2>/dev/null || exit "${status}"
