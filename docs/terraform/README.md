# Summary

Installing terraform on linux server based off (roughly) [guide from cloudflare ][def2]

## Steps 

1. Install from [hashicorp website][def]

```bash
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

2. Create [configuration][def4] files
3. Create [variables][def3] file
    1. Add to `.gitignore` so it isn't tracked
    2. Populate file with values required
4. Create [*provider*][def6] for cloudflare 
    1. This looks to be the actual upstream API / SDK which will peform the actions specified in the next file
5. Configure [Cloudflare resources][def5]
    1. This is the actual file that **does** the task/change on cloudflare

<!-- defintions -->

[def]: https://developer.hashicorp.com/terraform/install#linux
[def2]: https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/deploy-tunnels/deployment-guides/terraform/
[def3]: https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/deploy-tunnels/deployment-guides/terraform/#assign-values-to-the-variables
[def4]: https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/deploy-tunnels/deployment-guides/terraform/#5-create-terraform-configuration-files
[def5]: https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/deploy-tunnels/deployment-guides/terraform/#configure-cloudflare-resources
[def6]: https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/deploy-tunnels/deployment-guides/terraform/#configure-terraform-providers
