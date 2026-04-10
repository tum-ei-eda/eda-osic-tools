#!/usr/bin/env bash
__what__="verilator"
__detail__="Verilator - RTL simulation"

setup_apt() {
  echo "[setup apt] ${__what__} ..."

  general_apt_dep="verilator"
  apt update && \
    apt install --no-install-recommends -y ${general_apt_dep}
  status=$?

  echo "[setup apt] ${__what__} done."
  return "${status}"
}

__root__="$1"
echo -n "[setup] ${__detail__} (${__what__}) at '${__root__}'"
setup_apt
status=$?
echo -n "[setup] ${__detail__} (${__what__}) at '${__root__}' done."
return "${status}" 2>/dev/null || exit "${status}"
