# Installing NVIDIA Drivers with Secure Boot Enabled on Proxmox

When installing NVIDIA drivers on Proxmox with Secure Boot enabled, you need to sign the NVIDIA kernel modules. Using MOK (Machine Owner Key) is the easiest approach.

## 1. Install Required Packages

```bash
apt update
apt install shim-signed grub-efi-amd64-signed mokutil sbsigntool
```

## 2. Generate a MOK (Machine Owner Key)

```bash
mkdir -p /root/secureboot
cd /root/secureboot

# Generate the MOK key and certificate
openssl req -x509 -nodes -new -sha256 -days 3650 -newkey rsa:4096 \
    -subj '/CN=Machine Owner Key/' \
    -keyout mok.key -out mok.crt

# Convert to DER format for mokutil
openssl x509 -outform DER -in mok.crt -out mok.cer
```

## 3. Enroll the MOK

```bash
mokutil --import /root/secureboot/mok.cer
```

**Important:** This will prompt for a password - remember it! You'll need it after reboot.

## 4. Reboot and Complete MOK Enrollment

```bash
reboot
```

After reboot, the system will show a blue screen (MokManager) with a 10-second timeout:
- Press any key to enter MOK management
- Choose "Enroll MOK"
- Select "Continue" → "Yes"
- Enter the password you set in step 3
- Choose "Reboot"

## 5. Configure DKMS to Use Your MOK

Edit `/etc/dkms/framework.conf` and add:

```bash
echo "mok_signing_key=/root/secureboot/mok.key" >> /etc/dkms/framework.conf
echo "mok_certificate=/root/secureboot/mok.cer" >> /etc/dkms/framework.conf
```

## 6. Install NVIDIA Driver

Now you can install the NVIDIA driver normally:

```bash
# If using the .run file:
./NVIDIA-Linux-x86_64-570.172.08.run

# Or if using apt packages:
apt install nvidia-driver
```

The DKMS system will automatically sign the NVIDIA kernel modules with your MOK during installation.

## 7. Verify Everything Works

Check that Secure Boot is enabled and MOK is enrolled:

```bash
mokutil --sb-state
mokutil --list-enrolled
```

Check that NVIDIA modules are loaded:

```bash
nvidia-smi
lsmod | grep nvidia
```

## Alternative: Use DKMS Auto-Generated Key

If you prefer, DKMS can generate its own key automatically:

```bash
# Let DKMS generate its own key (will be in /var/lib/dkms/mok.pub)
# Just install the driver, then enroll the auto-generated key:
mokutil --import /var/lib/dkms/mok.pub
reboot
# Follow the same MOK enrollment process
```

## Notes

- The MOK approach is much simpler than managing custom db keys
- Works seamlessly with DKMS modules like NVIDIA drivers
- Once set up, future NVIDIA driver updates will be automatically signed
- All operations should be performed on the Proxmox host, not in containers
- Your Quadro P1000 GPU will work with either the standard `nvidia-driver` or `nvidia-tesla-470-driver` packages

## Troubleshooting

If you encounter dependency issues when installing the NVIDIA driver:

```bash
# Update and install prerequisites
apt update && apt upgrade
apt install linux-headers-$(uname -r) dkms

# Try specific driver version
apt install nvidia-driver-535

# Or use aptitude for better dependency resolution
apt install aptitude
aptitude install nvidia-driver
```