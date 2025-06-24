# Summary

SSH into a server by simply storing its config. 
ie: `ssh ha` to login

## SSH config

1. Edit your `~/.ssh/config` file
2. Add in the following

``` bash
host ha
   HostName 192.168.178.110 # whatever the ip address of your machine is
   User root # or hassio in your case
   Macs hmac-sha2-512-etm@openssh.com # message authentication codes to use. Used in homeassistant SSH
```

3. Test by simply connecting with `ssh ha` and it should automatically use the configuration