# Linux scripts

## User Management

Change shell from sh to bash etc  
```bash
chsh -s /bin/bash
```

[Reference here][def]

## Privileged access 

sudo as root interactively  
```bash
sudo -i
```

sudo as a specific user  
```bash
sudo -i -u user
```

[Reference here][def2]

## Find space hogs

Creates an alias to iteratively find 
```bash
alias ducks="du -sh --exclude=proc* --exclude=snap* --exclude=tmp/* * | sort -hr | head"
du -sh --exclude=proc* --exclude=snap* --exclude=tmp/* * | sort -hr | head
```

## Create an alias

Create an [alias][def4] for a command
`alias shortName="your custom command here"`
example:
`alias wr=cd /var/www/html"`

## TAR unzip unpack

Unpack a tar.gz file to a directory  
```bash
tar -xvzf example1.tar.gz -C ./Documents
``` 

## CHeck file permissions

Check file permissions in octal notion. ie: 0644

```bash
stat --format="%a" filename
```

[Reference here][def3]

## Copy SSH public key from windows to linux

Assumes .ssh folder exists already.

```powershell
cat ~/.ssh/id_rsa.pub | ssh <user>@<host> "cat >> ~/.ssh/authorized_keys"
```

[def]: https://www.cyberciti.biz/faq/how-to-change-shell-to-bash/
[def2]: https://unix.stackexchange.com/questions/176997/sudo-as-another-user-with-their-environment
[def3]: https://www.baeldung.com/linux/get-octal-file-permissions#:~:text=The%20stat%20command%20is%20the,the%20filename%2C%20and%20many%20others.
[def4]: https://www.tecmint.com/create-alias-in-linux/