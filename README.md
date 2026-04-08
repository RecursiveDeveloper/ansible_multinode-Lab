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

Ansible installation along with docker image build and container deployments are available through bash scripts to seamlessly recreate and modify configuration according to your needs.

To achieve SSH communication among master and worker nodes, SSH private and public keys are created previously within master node and then public key content is copied into authorized_keys file in /root/.ssh/ path inside each deployed container.

![Simple_Ansible-hands-on-docker_diagram](https://raw.githubusercontent.com/RecursiveDeveloper/static-media-content/refs/heads/main/Ansible_Multinode-Diagram.png)

## Tech Stack 

- **Client:** ---
- **Server:** ---
- **Database:** ---
- **Cloud provider:** ---
- **Tools:** Vagrant, Ansible, Docker

## Installation

1. Setup a Debian based operating system. You can use:
    * [Killercoda Playground](https://killercoda.com/playgrounds)
    * [Vagrant](https://developer.hashicorp.com/vagrant/downloads)
    * [WSL](https://learn.microsoft.com/en-us/windows/wsl/install)

2. Install Docker Engine in your operating system [Docker Install](https://docs.docker.com/engine/install/)

## Deployment

To deploy this project follow these steps:

1. In your master node or local machine, navigate into **ansible** folder and execute the provision script. This script will perform: 
    * Creation of the private and public keys needed to communicate with worker nodes
    * Creation of authorized_keys file with public key content
    * Ansible installation.

```bash
bash provision_master.sh
```

2. Then navigate into **docker** folder and execute the deploy script. This script will perform: 
    * Build of a docker image based on Dockerfile located in the same folder
    * Deployment of two containers with SSH service up and running
    * Copy of authorized_keys file in /root/.ssh/ path inside each deployed container

```bash
bash deploy_containers.sh
```

3. Check and copy containers Ip addresses into inventory.ini file inside ansible folder. To check container ip address, execute this command:

```bash
docker inspect <container_name> | grep -i ipaddress
```

Then manually copy the ip address and paste it into inventory.ini, replacing <container-ip> text, here is an example:

172.18.8.5 ansible_user=root ansible_ssh_private_key_file=/root/.ssh/id_ed25519

Repeat this process depending on the number of container you've deployed.

4. Check connectivity between master and nodes, navigate into ansible folder and execute

```bash
ansible all -m ping -i inventory.ini
```

5. If connection test is successful, execute playbook tasks into every worker node

```bash
ansible-playbook -i inventory.ini playbook.yml
```

For more informations about vagrant commands check [vagrant-cheat-sheet](https://gist.github.com/wpscholar/a49594e2e2b918f4d0c4)

If needed, you can modify playbook tasks to include all the tools you want to. Besides, requirements yaml file contains all the roles that will be installed, therefore if you plan to add or remove any role, erase the corresponding line both in requirements yaml file and in the playbook file.

## Authors

- [@RecursiveDeveloper](https://github.com/RecursiveDeveloper)

## License

[MIT](https://choosealicense.com/licenses/mit/)
