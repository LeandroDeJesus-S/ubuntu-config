#!/usr/bin/env bash
set -e

printout "[$0] started"

source ./functions.sh

if ! cmd_exist docker && cmd_exist systemctl; then
    # remove old docker stuffs
    try apt remove $(dpkg --get-selections docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc | cut -f1) 2>/dev/null

    # Add Docker's official GPG key:
    try apt update
    safe_apt_install ca-certificates curl >/dev/null
    try install -m 0755 -d /etc/apt/keyrings >/dev/null
    try curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc >/dev/null
    try chmod a+r /etc/apt/keyrings/docker.asc >/dev/null

    # Add the repository to Apt sources:
    tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

    try apt update >/dev/null

    # lastest version of docker packages
    safe_apt_install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    if [[ "$(systemctl is-active docker)" != "active" ]]; then
        try systemctl start docker
    fi

    groupadd docker
    usermod -aG docker $USER
    newgrp docker

    # configure logging rotation
    if [[ ! -d "/etc/docker" ]]; then
        mkdir -p /etc/docker
    fi
    echo <<EOF
{
"log-driver": "json-file",
"log-opts": {
    "max-size": "10m",
    "max-file": "3"
}
}
EOF > /etc/docker/daemon.json
fi

install_optionals && safe_brew_install jesseduffield/lazydocker/lazydocker

printout "[$0] finished"
