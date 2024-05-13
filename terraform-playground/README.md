## Setup

### 1. npm installation


### 1. Ansible installation


```sh
source ./setup.sh
```

### 2. Config setup

You need to have keyfile ``tf-key.json``
Also you may need to override [provider configuration settings](terraform/variables.tf)

Also you will need to specify user . create ``config``

```
public_ssh_key_path   = "~/.ssh/yandex-vm.pub"
private_ssh_key_path  = "~/.ssh/yandex-vm"
account_key_file_path = "../tf-key.json"
folder_id = "******"
```

### 3. add ssh-key to agent
```sh
ssh-add  ~/.ssh/yandex-vm
```

## Execution

#### 1. plan
```sh
terraform -chdir=terraform plan -var-file=../config.tfvars
```

#### 2. apply
```sh
terraform -chdir=terraform apply -var-file=../config.tfvars
```