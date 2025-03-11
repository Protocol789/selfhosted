> The qemu-guest-agent is a helper daemon, which is installed in the guest. It is used to exchange information between the host and guest, and to execute command in the guest.
> 
> In Proxmox VE, the qemu-guest-agent is used for mainly three things:
> 
> To properly shutdown the guest, instead of relying on ACPI commands or windows policies
> To freeze the guest file system when making a backup/snapshot (on windows, use the volume shadow copy service VSS). If the guest agent is enabled and running, it calls guest-fsfreeze-freeze and guest-fsfreeze-thaw to improve consistency.
> In the phase when the guest (VM) is resumed after pause (for example after shapshot) it immediately synchronizes its time with the hypervisor using qemu-guest-agent (as first step).

Used this link:
https://pve.proxmox.com/wiki/Qemu-guest-agent#Linux

