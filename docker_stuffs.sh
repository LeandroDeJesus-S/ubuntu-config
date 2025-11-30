#!/usr/bin/env bash
set -e

printout "[$0] started"

source ./functions.sh
# remove old docker stuffs
sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc | cut -f1) 2>/dev/null

# Add Docker's official GPG key:
sudo apt update >/dev/null
sudo apt install ca-certificates curl >/dev/null
sudo install -m 0755 -d /etc/apt/keyrings >/dev/null
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc >/dev/null
sudo chmod a+r /etc/apt/keyrings/docker.asc >/dev/null

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update >/dev/null

# lastest version of docker packages
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y >/dev/null
echo "$(docker --version) installed successfully"
echo "$(docker compose --version) installed successfully"

if [[ "$(sudo systemctl is-active docker)" =~ "active" ]]; then
    sudo systemctl start docker
fi

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

echo "Docker rootless successfully configured, Log out and log back in."

# configure logging rotation
if [[ ! -d "/etc/docker" ]]; then
    sudo mkdir -p /etc/docker
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

safe_brew_install jesseduffield/lazydocker/lazydocker

printout "[$0] finished"
