#!/bin/bash

set -euo pipefail

INVENTORY="inventory.ini"

containers_ip=( $(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -q)) )

if [ ${#containers_ip[@]} -eq 0 ]; then
  echo "No running containers found"
  exit 1
fi

if [ -f ${INVENTORY} ]; then
  rm ./ansible/${INVENTORY}
fi
touch ./ansible/${INVENTORY}

for container_ip in "${containers_ip[@]}"
do
  echo -e "${container_ip} ansible_user=ansible ansible_ssh_private_key_file=./id_ed25519 ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'" >> ./ansible/${INVENTORY}
done