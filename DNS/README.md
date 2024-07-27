![alt text](pi-logo.png)

Network-wide ad blocking via your own Linux hardware
The Pi-hole® is a DNS sinkhole that protects your devices from unwanted content without installing any client-side software.

# Summary

Provides DNS and network wide advert blocking for site.

## Configuration 

| Host           | Install | Config       |
| -------------- | ------- | ------------ |
| proxmox 1 + 2    | LXC        | GUI / SSH |

### Side car config 

* The DNS entries are kepty in sync via [Orbital Sync](<../software/orbital sync/README.md>) 

## Links

http://pitwo.server/admin  
http://pione.server/admin

### Install 

[Guide](https://tteck.github.io/Proxmox/#pi-hole-lxc)  
 `bash -c "$(wget -qLO - https://github.com/tteck/Proxmox/raw/main/ct/pihole.sh)"`

tab
