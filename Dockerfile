FROM ubuntu:xenial
LABEL maintainer="Wes Bonelli"

# RUN mkdir -p ${SINGULARITY_ROOTFS}/code

COPY iinit.sh /code/iinit.sh

ENV IRODS_VERSION=4.2.2

RUN apt-get update && apt-get install -y \
    wget \
    sudo \
    apt-transport-https

RUN wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 && \
    chmod +x jq-linux64 && \
    mv jq-linux64 /usr/bin/jq

RUN wget -qO - https://packages.irods.org/irods-signing-key.asc | sudo apt-key add -

RUN echo "deb [arch=amd64] https://packages.irods.org/apt/ xenial main" | sudo tee /etc/apt/sources.list.d/renci-irods.list

RUN apt-get update && apt-get install -y \
    irods-runtime=${IRODS_VERSION} \
    irods-icommands=${IRODS_VERSION} \
    libxml2

# %apprun iinit
#   exec /bin/bash /code/iinit.sh "${@}"

