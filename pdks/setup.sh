#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
__what__="pdks"
__detail__="PDKs"

__root__="$1"
mkdir -p "${__root__}"
echo -n "[setup] ${__detail__} (${__what__}) at '${__root__}'"
"${SCRIPT_DIR}/ihp_sg13g2/setup.sh" "${__root__}/ihp_sg13g2"
status=$?
echo -n "[setup] ${__detail__} (${__what__}) at '${__root__}' done."
return "${status}" 2>/dev/null || exit "${status}"
