## 🚀 About Me
I'm a junior DevOps engineer with some expertise in BackEnd development using Java and Node.js; scripting skills with Python, Bash and JavaScript; besides CI/CD and cloud knowledge of AWS and Azure DevOps tools ...

<p align="center">
<img src="https://c4.wallpaperflare.com/wallpaper/694/164/1000/digital-art-animals-eagle-bird-of-prey-birds-hd-wallpaper-preview.jpg" alt="Logo" width="400" height="230">
</p>

![linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![javascript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)
![nodejs](https://img.shields.io/badge/Node.js-43853D?style=for-the-badge&logo=node.js&logoColor=white)
![mysql](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white)
![jenkins](https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=Jenkins&logoColor=white)
![aws](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)
![azuredevops](https://img.shields.io/badge/Azure_DevOps-0078D7?style=for-the-badge&logo=azure-devops&logoColor=white)

## 🔗 Portfolio
[![portfolio](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/RecursiveDeveloper)
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/jhoan-jesus-ortiz-sandoval-a66152198/)

# Master - worker nodes configuration management environment using Ansible and Docker

Simulate a distributed master - worker nodes configuration management environment using Ansible and Docker:
- 1 master node
- 2 worker nodes deployed as docker containers from one pre-built image

The image build, SSH key creation and container deployments are available through a single bash script to seamlessly recreate and modify the configuration according to your needs.

To achieve SSH communication between master and worker nodes, an SSH key pair is generated and the public key is baked into the Docker image during the build, inside `/home/ansible/.ssh/authorized_keys`. Every container is therefore SSH-ready as soon as it starts, and Ansible connects to the `ansible` user with passwordless sudo privileges.

![Simple_Ansible-hands-on-docker_diagram](https://raw.githubusercontent.com/RecursiveDeveloper/static-media-content/refs/heads/main/Ansible_Multinode-Diagram.png)

## Project Structure

```
ansible_multinode-Lab/
├── .gitignore
├── README.md
├── deploy.sh                    # Installs Ansible, generates SSH keys, builds the image, deploys containers
├── destroy.sh                   # Removes containers, image and generated SSH artifacts
├── ansible/
│   ├── inventory.ini            # Inventory with container IPs, ansible user and SSH private key path
│   ├── setup_inventory.sh       # Auto-generates the inventory from running container IPs
│   └── playbook.yml             # Playbook that updates apt and installs nginx on the worker nodes
└── docker/
    └── Dockerfile               # Ubuntu image with SSH server and a dedicated 'ansible' sudo user
```

## Tech Stack

- **Server:** Ubuntu 22.04 (jammy)
- **Configuration management:** Ansible
- **Containerization:** Docker
- **Tools:** Bash, SSH

## Prerequisites

Before deploying this project, ensure you have the following prerequisites in place:

1. **A Debian-based operating system.** You can use:
    * [Killercoda Playground](https://killercoda.com/playgrounds)
    * [Vagrant](https://developer.hashicorp.com/vagrant/downloads)
    * [WSL](https://learn.microsoft.com/en-us/windows/wsl/install)

2. **Docker Engine** installed and running. [Docker Install](https://docs.docker.com/engine/install/)

3. **Ansible** (optional). If it is not installed, `deploy.sh` installs it automatically via the official PPA.

## Deployment

To deploy this project from the project root, follow these steps:

1. Run the deploy script:

```bash
bash deploy.sh
```

This script performs:
- Ansible installation (only if it is not already installed)
- Creation of the SSH key pair (`id_ed25519` / `id_ed25519.pub`)
- Creation of the `authorized_keys` file with the public key content
- Removal of any existing containers and image
- Build of the Docker image with the public key baked into `/home/ansible/.ssh/authorized_keys`
- Deployment of two containers (`ubuntu1` on host port `8080`, `ubuntu2` on host port `8081`) with the SSH service up and running

2. Generate the Ansible inventory from the running containers:

```bash
bash ansible/setup_inventory.sh
```

This script inspects all running containers, retrieves their IP addresses, and populates `ansible/inventory.ini` automatically.

3. Test connectivity between the master and the worker nodes:

```bash
ansible all -m ping -i ansible/inventory.ini
```

4. If the connection test is successful, run the playbook tasks on every worker node:

```bash
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml
```

The playbook updates the apt cache (with a `cache_valid_time` of 3600 seconds), installs nginx and ensures the service is started and enabled.

5. To tear down the environment (containers, image, SSH keys and `authorized_keys` artifacts):

```bash
bash destroy.sh
```

If needed, you can modify the playbook tasks to include all the tools you want to install on the worker nodes.

## Authors

- [@RecursiveDeveloper](https://github.com/RecursiveDeveloper)

## License

[MIT](https://choosealicense.com/licenses/mit/)
