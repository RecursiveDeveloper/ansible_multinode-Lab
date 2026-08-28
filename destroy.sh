#!/bin/bash

set -euo pipefail

image_name="ubuntu_ssh_demo"
tag="latest"

check_containers=$(docker ps -aq --filter "ancestor=${image_name}:${tag}")
if [[ ${check_containers} ]]; then
  docker rm -f ${check_containers}
fi

if docker image inspect ${image_name}:${tag} >/dev/null 2>&1; then
  docker rmi -f ${image_name}:${tag}
fi

if ls *id_ed25519* >/dev/null 2>&1; then
  rm -f ./id_ed25519.pub ./id_ed25519
fi

if [ -f "./docker/authorized_keys" ]; then
  rm -f ./docker/authorized_keys
fi