#!/bin/bash

set -euo pipefail

image_name="ubuntu_ssh_demo"
tag="latest"
container_names=("ubuntu1" "ubuntu2")
default_port="8080"

if ! command -v ansible &> /dev/null; then
  sudo apt update -y
  sudo apt install -y software-properties-common
  sudo add-apt-repository --yes --update ppa:ansible/ansible
  sudo apt install -y ansible
fi

if ls *id_ed25519* >/dev/null 2>&1; then
  rm -f ./id_ed25519.pub ./id_ed25519
fi

if [ -f "./authorized_keys" ]; then
  rm -f ./authorized_keys
fi

ssh-keygen -t ed25519 -f ./id_ed25519 -C "ansible" -N ""
cat ./id_ed25519.pub > ./authorized_keys
mv ./authorized_keys ./docker/authorized_keys

check_containers=$(docker ps -aq --filter "ancestor=${image_name}:${tag}")
if [[ ${check_containers} ]]; then
  docker rm -f ${check_containers}
fi

if docker image inspect ${image_name}:${tag} >/dev/null 2>&1; then
  docker rmi -f ${image_name}:${tag}
fi

docker build -t ${image_name}:${tag} ./docker
for container in ${container_names[@]}; do
  docker run -d --name ${container} -p ${default_port}:80 ${image_name}:${tag}
  default_port=$((default_port + 1))
done