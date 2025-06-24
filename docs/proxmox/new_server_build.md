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
