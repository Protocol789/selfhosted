# Summary

Guides you on how to install Ansible and get a base project up and running. 

## Steps to install

1. Creat a virtual python3 enviornment via [this](https://packaging.python.org/en/latest/guides/installing-using-pip-and-virtual-environments/) link.  
  1.1 `python3 -m venv .venv` in the project folder that requires it
2. Install pipx `apt install pipx`
3. Install [ansible-generator](https://github.com/kkirsche/ansible-generator) which creates the base directory directory for you.
   3.1 `pipx install ansible-generator`
   3.2 Run the generator with `ansible-generate` and it'll create the directory layout for you.

## Configuration 

1. Run `ansible-generate -r role1 role2` to generate a role layout for you.

### Ansible Vault

- (optional) Set editor to nano via guide [here][def] 

#### Vault management 

1. `ansible-vault create vault.yml` Create Vault 
2. `cat vault.yml` Look at encrypted vault file
3. `ansible-vault view vault.yml` View the encrypoted files
4. `ansible-vault edit vault.yml` Edit vault file contents

- `ansible-vault encrypt encrypt_me.txt` Encrypt existing files

#### Encrypt a string

Adapted from [here][def2]

Create a vault encrypted variable 


Encrypt a piece of text using a vault password file
1. `ansible-vault encrypt_string --vault-id dev@a_password_file 'foooodev' --name 'the_dev_secret' --encrypt-vault-id dev`

Descrypt a vault encrypted variable (above is saved to file)
2. `ansible localhost -m ansible.builtin.debug -a var="the_dev_secret" -e "@vars.yml" --vault-id dev@a_password_file`

##### Running Ansible with Vault-Encrypted Files

1. `echo 'my_vault_password' > .vault_pass`  Create file with vault password in it
2. `echo '.vault_pass' >> .gitignore` Add it it git ignore so it doesn't get commitedd

##### Reading the Password File Automatically

1. `nano ansible.cfg` Open your ansible config
2. Add the path to the file below so that ansible automatically loads this when working with a vault

```
[defaults]
. . .
vault_password_file = ./.vault_pass
```


##### View all vars view ansible debug

```
ansible -i production.yml dockerhost01 -m debug -a 'var=hostvars[inventory_hostname]'
```

`-i production.yml` The inventory you are looking at
`dockerhost01` The host you are interested in
`-m debug` Module to run
`-a var=hostvars[inventory_hostname]` Module arguments

[def]: https://www.digitalocean.com/community/tutorials/how-to-use-vault-to-protect-sensitive-ansible-data
[def2]: https://docs.ansible.com/ansible/latest/vault_guide/vault_encrypting_content.html#creating-encrypted-variables
