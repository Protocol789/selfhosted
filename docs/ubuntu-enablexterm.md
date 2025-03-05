# Summary

Enables `xterm.js` on proxmox VM guest for Ubuntu

## Steps

> 1. Add a virtual serial port to the VM using PVE Web GUI and restart the VM
> 2. Enable and start the virtual serial port on VM, change tty number as needed (Reference: https://askubuntu.com/a/621209/838946)
> `sudo systemctl enable serial-getty@ttyS0.service`
> `sudo systemctl start serial-getty@ttyS0.service`
> 3. Done! You can now select xterm.js in the PVE Web GUI

### Tested on

OS: Ubuntu 22.04.5 LTS
Proxmox: 8.3.4

### Links

Referenced from a random github gist [here](https://gist.github.com/xmesaj2/3ea1c35b5215d34a7c9e182c7486653f)
