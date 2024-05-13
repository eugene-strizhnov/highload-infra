
You need to have keyfile ``tf-key.json``
Also you may need to override [provider configuration settings](terraform/variables.tf)

Also you will need to specify user . It can be done either with dinoing set of users, or just with providign ssh key.

```sh
export TF_VAR_public_ssh_key=$PUBLIC_SSH_KEY
terraform -chdir=terraform -var-file=foo.tfvars plan
```
