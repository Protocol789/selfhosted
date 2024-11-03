
### Run on the linux server 

# Set root password 
`passwd root`

# Allow root to login and permit password
`sed -i -e 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' -e 's/^PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config`

# Create host keys 
`ssh-keygen -A`

---

### Run from Windows client device 

This uploads the private key located on local windows pc to a remote server

```ps
# Set variables
$key = $env:USERPROFILE + '\.ssh\id_rsa.pub'
$server = 'unifi.zorab.im'
$user = 'root'

# Connect and place key into authorized_keys
type $key | ssh $user@$server "cat >> .ssh/authorized_keys"
```

#### Restart SSH service

Restart the SSH service on target machine so authorized keys takes effect
`systemctl restart sshd`

#### Test

`ssh $user@$server` This should instantly log you in
example: `ssh root@192.168.1.1`
ssh 