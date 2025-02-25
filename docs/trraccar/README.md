## Summary

How to setup tailscale proxy on VPS using IPtables

## Step 1: Tailscale 

1. Install Tailscale on VPS & Local Server

```shell
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
```
2. Get the Local Server’s Tailscale IP

`tailscale ip`
Example output: 100.64.0.2

# Step 2: Configure iptables to Forward Traffic

```shell
VPS_INTERFACE="eth0"  # Change if needed
LOCAL_IP="10.100.100.2"  # WireGuard IP (or Tailscale IP like 100.64.0.2)

# Enable IP Forwarding
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
sudo sysctl -w net.ipv4.ip_forward=1

# Forward ports 5000-5200 to the local server
sudo iptables -t nat -A PREROUTING -i $VPS_INTERFACE -p tcp --dport 5000:5200 -j DNAT --to-destination $LOCAL_IP
sudo iptables -t nat -A POSTROUTING -p tcp --dport 5000:5200 -j MASQUERADE

# Save iptables rules (Debian/Ubuntu)
sudo apt install iptables-persistent -y
sudo netfilter-persistent save
```

## Step 3: Verify and Test

Check Tailscale is connected:
`ping 100.64.0.2  # Tailscale`

Test Port Forwarding:
`nc -zv <VPS_PUBLIC_IP> 5055`

###


. View PREROUTING Rules (NAT Table)
To check if traffic is being redirected before routing:

```sh
sudo iptables -t nat -L PREROUTING -v -n
```

* `-t nat` : Selects the NAT table (where PREROUTING is found).
* `-L PREROUTING` : Lists all PREROUTING rules.
* `-v -n` : Shows details (verbose) and avoids DNS lookups for faster output.
```