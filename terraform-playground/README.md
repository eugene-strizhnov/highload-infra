## Description

This project serves as a playground for experimenting with various infrastructure technologies. 
It is structured into three main components:

1) A Node.js + Remix web application.
2) Terraform scripts to provision a virtual machine (VM) on Yandex.Cloud.
3) Ansible scripts to deploy the web application to the VM and configure Nginx as a reverse proxy/load balancer for the application.

The entire setup can be built and configured using a single ``terraform apply`` command.

## Setup

### 1. Node.js installation

Ensure you have Node.js version 18.0 or higher installed. 
You can download it from Node.js [official website](https://nodejs.org/en/download) or use the [nvm tool](https://github.com/nvm-sh/nvm) for easier version management.

#### 1.1. Install cross-env

Make sure [cross-env](https://www.npmjs.com/package/cross-env) is available in your PATH by running:
```sh
npm install --global cross-env
```

### 2. Ansible installation

Use ``setup.sh`` to configure a Python virtual environment (venv) and install the necessary Ansible dependencies:
```sh
source ./setup_ansible.sh
```

### 3. Config setup

You must have a service account key file (e.g. named ``tf-key.json``).
You have to specify its name along with folder id and path to you public ssh key in th ``config.tfvars`` file:
```
public_ssh_key_path   = "~/.ssh/yandex-vm.pub"
account_key_file_path = "../tf-key.json"
folder_id = "******"
```

### 4. Add ssh-key to agent

Add your SSH key to the SSH agent by running:
```sh
ssh-add  ~/.ssh/yandex-vm
```

## Execution

#### 1. init
```sh
terraform -chdir=terraform init
```

#### 2. plan
```sh
terraform -chdir=terraform plan -var-file=../config.tfvars
```

#### 3. apply
```sh
terraform -chdir=terraform apply -var-file=../config.tfvars
```

#### 4. destroy
```sh
terraform -chdir=terraform destroy -var-file=../config.tfvars
```
