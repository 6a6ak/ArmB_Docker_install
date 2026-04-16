#!/usr/bin/env bash

# Clean + correct Docker install for Armbian (Ubuntu noble)
# Target user: telemetry

set -e

USER_NAME="telemetry"

echo "[1] Remove wrong Docker repo..."
sudo rm -f /etc/apt/sources.list.d/docker.*

echo "[2] Install prerequisites..."
sudo apt update
sudo apt install -y ca-certificates curl gnupg

echo "[3] Add Docker GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
| sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "[4] Add correct Docker repo (Ubuntu noble)..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu noble stable" \
| sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "[5] Install Docker..."
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "[6] Enable Docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo "[7] Add user to docker group..."
sudo groupadd docker 2>/dev/null || true
sudo usermod -aG docker "$USER_NAME"

echo "[8] Apply group..."
newgrp docker <<EONG
echo "Docker group applied"
EONG

echo
echo "=== TEST ==="
docker --version
docker run hello-world

echo
echo "DONE ✔️"
echo "If docker still needs sudo → logout/login"