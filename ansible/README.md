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

Run `ansible-generate -r role1 role2` to generate a role layout for you
