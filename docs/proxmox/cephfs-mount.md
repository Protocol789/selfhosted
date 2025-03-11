# Summary

This document shows you how to setup a ceph fs mount in linux
Based of [convo from Chat GPT][def] 

## Steps

1. Install Ceph Tools in Your VM
Ensure your VM has the ceph-common package installed (required for mounting CephFS):

`sudo apt update && sudo apt install ceph-common -y`

2. Create a Ceph Authentication Key (Recommended)

Instead of using the admin key (which has full cluster access), create a limited-access CephFS key:

  1. On a Proxmox node, generate a key for a new Ceph user:
    `ceph auth get-or-create client.vmuser mon 'allow r' mds 'allow rw' osd 'allow rw pool=cephfs_data'`

  2. Copy the key from the output. It will look like:
```
    [client.vmuser]
    key = AQD123abcXYZ...
```
  
  3. Create the Ceph keyring
  `echo AQD123abcXYZ... | sudo tee /etc/ceph/ceph.client.vmuser.keyring` 


3. Add CephFS Mount to `/etc/fstab`

Edit the `/etc/fstab` file to automatically mount CephFS on boot:

`sudo nano /etc/fstab`
Add this line (replace <MON_IPs> with your actual Ceph MON IPs and <vmuser> if using the limited key):

```bash
<MON_IP1>,<MON_IP2>,<MON_IP3>:/ /mnt/cephfs ceph name=vmuser,secretfile=/etc/ceph/ceph.client.vmuser.keyring,_netdev 0 2
```

Example

``` bash
# /etc/fstab 
192.168.1.10,192.168.1.11,192.168.1.12:/ /mnt/cephfs ceph name=vmuser,secretfile=/etc/ceph/ceph.client.vmuser.keyring,_netdev 0 2
```

- `_netdev` ensures the mount waits for the network to be ready before attempting to mount.
- `name=vmuser` specifies the limited-access user.
- `secretfile` ensures secure authentication via a password file


4. Test the Mount
Manually test mounting before rebooting:


```bash
sudo mount -a
ls /mnt/cephfs
```

5. Verify on Reboot

Reboot the VM:
`sudo reboot`

After rebooting, check if CephFS is mounted:
`df -h | grep ceph`

<!-- defintions -->

[def]: https://chatgpt.com/share/67d0ad89-0868-8010-a1a7-ffb3a9005dc2
