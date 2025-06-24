# Summary

Create own DEbian 12 cloud initi template

TAKEN FROM HERE
https://pycvala.de/blog/proxmox/create-your-own-debian-12-cloud-init-template/
Also used [this](https://pycvala.de/blog/proxmox/create-your-own-debian-12-cloud-init-template/) to setup an Ubuntu template images 

## Steps 

## Step 1. Accessing the Proxmox Host
To start our journey, let’s access your Proxmox host. Simply connect through SSH and replace pve-host-ip with the IP address or hostname of your Proxmox server.

`ssh root@pve-host-ip`
Explanation:

The SSH command allows us to connect remotely to the Proxmox host as the root user, providing access to the Proxmox command-line interface.

## Step 2. Downloading the Debian Cloud Image
Let’s obtain the Debian cloud image designed for cloud environments using the wget command.

`wget https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2`
Explanation:

The wget command downloads the latest Debian cloud image in QCOW2 format from the specified URL.

## Step 3. Creating the VM on Proxmox

Now, let’s create the VM on Proxmox using the qm create and qm set commands to configure the VM properties.

`qm create 9000 --name debian12-cloudinit --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-pci --machine q35` 

Explanation:

* `qm create 9000`: Creates a new VM with ID 9000.
* `--name debian12-cloudinit`: Names the VM as “debian12-cloudinit”.
* `--net0 virtio,bridge=vmbr0`: Configures the first network interface to use the “virtio” driver and be bridged to “vmbr0”.
* `--scsihw virtio-scsi-pci`: Sets the SCSI controller hardware to “virtio-scsi-pci”.
* `--machine q35`: Uses the Q35 machine type for the VM.

## Step 4 Configuring Disk and Memory

Our VM needs a disk and memory to function properly. Let’s set up the disk and resize it to a suitable size, say, 8GB.

```sh
qm set 9000 --scsi0 local-lvm:0,discard=on,ssd=1,format=qcow2,import-from=/root/debian-12-generic-amd64.qcow2
qm disk resize 9000 scsi0 8G
```
Explanation:


* `qm set 9000 --scsi0 local-lvm:0,discard=on,ssd=1,format=qcow2,import-from=/root/debian-12-generic-amd64.qcow2` : Sets the first SCSI disk with ID 0 to use the local-lvm storage, with options for discard, SSD, and QCOW2 format. It imports the Debian cloud image we downloaded earlier as the disk’s content.
* `qm disk resize 9000 scsi0 8G`: Resizes the disk with ID 0 of VM 9000 to 8GB.


5. Setting the Boot Order
Ensure our VM knows how to boot correctly. Set the boot order to prioritize booting from the disk.

`qm set 9000 --boot order=scsi0`

    Explanation:
    Sets the boot order for VM 9000 to boot from the first SCSI disk with ID 0.

6. Configuring CPU and Memory Resources
Our VM needs enough resources to perform its tasks. Configure the CPU and memory allocation accordingly.

`qm set 9000 --cpu host --cores 2 --memory 2048`

    Explanation:
    Sets VM 9000 to use the host CPU model, with 2 CPU cores, and allocate 2048 MB (2GB) of memory.

7. Configuring BIOS and EFI
To enable smooth functioning, we need to set the BIOS and EFI properties for our VM.

<!-- `qm set 9000 --bios ovmf --efidisk0 local-lvm:1,format=qcow2,efitype=4m,pre-enrolled-keys=1` -->
> Had to set ceph-pool instead of local-lvm

`qm set 9002 --bios ovmf --efidisk0 ceph-pool:1,format=qcow2,efitype=4m,pre-enrolled-keys=1`

    Explanation:

    `qm set 9000 --bios ovmf`: Configures VM 9000 to use the OVMF BIOS.
    --efidisk0 local-lvm:1,format=qcow2,efitype=4m,pre-enrolled-keys=1: Sets the first EFI disk with ID 1 to use the local-lvm storage, with QCOW2 format, an EFI partition size of 4MB, and pre-enrolled keys for secure boot.

8. Setting up Cloud-Init
Empower your VM with cloud-init capabilities by attaching the cloud-init drive.

`qm set 9000 --ide2 local-lvm:cloudinit`

    Explanation:
    Sets the second IDE disk with ID 2 to use the local-lvm storage, which will serve as the cloud-init drive for the VM.

9. Enabling QEMU Guest Agent
Enhance VM interaction by enabling the QEMU guest agent.

`qm set 9000 --agent enabled=1` 

Explanation:

Enables the QEMU guest agent for VM 9000, allowing better communication with the VM from the host.
