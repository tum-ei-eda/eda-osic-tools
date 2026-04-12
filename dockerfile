ARG BASE_IMAGE=ubuntu:latest
ARG workspace_dir=/eda-osic-tools
ARG ENV_VENV_ROOT=/venv
###########################################################
FROM ${BASE_IMAGE} AS eda-osic-tools
SHELL ["/bin/bash", "-lc"]
ARG workspace_dir=/eda-osic-tools
ARG ENV_VENV_ROOT=/venv
# overall build config
ENV workspace_dir=${workspace_dir}
ENV VENV_ROOT=${ENV_VENV_ROOT}
#####################
# Docker CA Certif. #
#####################
RUN apt update && \
    apt install -y ca-certificates && \
    update-ca-certificates
###########
# general #
###########
RUN \
  --mount=type=bind,source=".",target=${workspace_dir} \
  echo -n "test" && \
  . "${workspace_dir}/setup.sh" "${VENV_ROOT}" "${workspace_dir}" && \
  test -f "${VENV_ROOT}/bin/activate"
########
# orfs #
########
RUN \
  --mount=type=bind,source=".",target=${workspace_dir} \
  . "${workspace_dir}/env.sh" "${workspace_dir}/.env" && \
  . "${workspace_dir}/orfs/setup.sh" "/orfs-src" "${ORFS_ROOT}"
#############
# verilator #
#############
RUN \
  --mount=type=bind,source=".",target=${workspace_dir} \
  . "${workspace_dir}/env.sh" "${workspace_dir}/.env" && \
  . "${workspace_dir}/verilator/setup.sh"
########
# pdks #
########
RUN \
  --mount=type=bind,source=".",target=${workspace_dir} \
  . "${workspace_dir}/env.sh" "${workspace_dir}/.env" && \
  . "${workspace_dir}/pdks/setup.sh" "${PDK_ROOT}"
#########################
RUN \
  --mount=type=bind,source=".",target=${workspace_dir} \
  rm -rf /var/lib/apt/lists/*

WORKDIR ${workspace_dir}
COPY . ${workspace_dir}
