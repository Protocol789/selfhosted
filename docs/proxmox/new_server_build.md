# First Run Server Checklist

This document outlines the essential tasks and activities to be completed when provisioning a new server. Follow these steps to ensure all necessary configurations are made and no critical setup is forgotten.

---

# First Run Server Checklist

This document outlines the essential tasks and activities to be completed when provisioning a new server. Follow these steps to ensure all necessary configurations are made and no critical setup is forgotten.

---

## 🔧 System Configuration

- [ ] **Disable Cloud-init**  

  Prevent Cloud-init from running on future boots by creating the following file:
  ```bash
  sudo touch /etc/cloud/cloud-init.disabled
  ```
- [ ] **Add user to sudo** 

  Add to group
  ```bash
  sudo usermod -aG sudo daniel
  ```

```bash
# 🛠 Steps
# Create a group:

sudo groupadd dockeditors
# Add users to the group:
sudo usermod -aG dockeditors cisuer
sudo usermod -aG dockeditors daniel

# Set the group ownership of the directory:
sudo chown -R root:dockeditors /docker

# Make all files group-writable:
sudo chmod -R g+rw /docker

# Ensure new files inherit the group:
sudo find /docker -type d -exec chmod g+s {} +

# Logout and back in to reflect
``` 

```bash
#!/bin/bash

USERNAME="daniel"
PUBKEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM6OM3GH4Y5+4y1B229qxKEN9rIuwuPBosJp+QF8DmVt dj_pr@zorab-surface"

# 1. Create user and home directory
sudo useradd -m -s /bin/bash "$USERNAME"

# 2. Add to sudo group
sudo usermod -aG sudo "$USERNAME"

# 3. Create .ssh directory
sudo mkdir -p /home/"$USERNAME"/.ssh

# 4. Add the SSH key
echo "$PUBKEY" | sudo tee /home/"$USERNAME"/.ssh/authorized_keys > /dev/null

# 5. Set permissions
sudo chown -R "$USERNAME":"$USERNAME" /home/"$USERNAME"/.ssh
sudo chmod 700 /home/"$USERNAME"/.ssh
sudo chmod 600 /home/"$USERNAME"/.ssh/authorized_keys

echo "✅ User '$USERNAME' created and SSH key installed."
```

- [ ] Install DNS utilities for DIG etc
  `sudo apt install dnsutils`

---

## 🧠 Server Inventory and Documentation

- [ ] **Add Server to Beszel**  
  Ensure the server is registered in your internal tracking or inventory tool (e.g., Beszel).

- [ ] **Add to Grist (Server Tracker)**  
  Record the server's IP address and status in the central server documentation.  
  👉 [Grist Server Tracker](https://docs.getgrist.com/uPudgVrqr5ce/Servers)

- [ ] **Add to Ansible Inventory**  
  Include the server in the Ansible inventory file, using the appropriate hostname and address.  
  Example:
  ```yaml
  proxmox5:
    ansible_host: proxmox5.server
  ```

---

## 🌐 Networking and Monitoring

- [ ] **Configure DNS on Pi-hole**  
  Assign a static DNS entry for the server within the Pi-hole admin interface.

- [ ] **Add to Uptime Kuma**  
  Set up monitoring in Uptime Kuma to track availability and uptime.

---

## ✅ Additional Notes

- Update this checklist as needed based on changes to your infrastructure or workflow.
- Consider creating an automated script for repeatable first-run steps.

---

## 📌 TODO (Optional Future Additions)

- Add SSH key management reminders  
- Configure logging (e.g., syslog or remote journald)  
- Enable automatic updates or patch schedules  
- Install baseline monitoring agents or security tools  

---

Maintained by the Infrastructure Team.
