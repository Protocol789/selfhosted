# Summary

Get unifi cetificate applied to dream machine (or any other unifi device)

## Prerequistates

- SSH access
- DNS
  - A record to the unifi device / controller
  - Utilised the local domain feature of unifi so the address unifi.zorab.im resolves to itself
- Lets Encrypt certificate for wildcard domain (or specific the the unifi host name + domain)

## Steps 

### Install script

> 1. Copy the [link location][def] of the script.
> 2. SSH into your Ubuntu/Debian machine, and login as root. ( Ubuntu | sudo -i | Debian | su )
> 3. Make sure the ca-certificates package is installed.
`apt-get update; apt-get install ca-certificates curl -y`
> 4. Download and execute the script!
`curl -sO https://get.glennr.nl/unifi/extra/unifi-easy-encrypt.sh && bash unifi-easy-encrypt.sh`
5. `bash ./easy-encrypt.sh --skip --fqdn unifi.zorab.im --private-key private.key --own-certificate --signed-certificate fullchain.pem`

Explanation:
- `bash ./easy-encrypt.sh` Run the script with bash
- `--skip` Skip any kind of manual input.
- `--fqdn` Specify what domain name ( FQDN ) you want to use, you can specify multiple domain names with : as separator,.
- `--private-key` Specify path to your private key
- `--own-certificate` Requirement if you want to import your own paid certificates with the use of `--skip`
- `--signed-certificate` Specify path to your signed certificate 

### Get LE certfifcate

Jump onto box hosting the LE certificate renewal mechanics and grab the `acme.json` and parse it as follows.
Goal here is to get the certifcate and the private key extracted. In this instance the certificate is a wilcard cert for the domain `*.zorab.im`

```ps
$acme = gc acme.json | ConvertFrom-Json
$cert =  $acme.cloudflare.Certificates.certificate

$cert_pem = [Text.Encoding]::Utf8.GetString([Convert]::FromBase64String($cert))
$cert_pem | out-file cert.pem

$key = $acme.cloudflare.Certificates.key
[Text.Encoding]::Utf8.GetString([Convert]::FromBase64String($key))
$key | out-file private.key
```

One liner using jq on linux to extract the info instead of powereshell 

```bash
jq -r '.le.Certificates[] | select(.domain.main==\"'example.com'\") | .certificate' /data/acme.json | base64 -d > /out/tls_cert.pem;
jq -r '.le.Certificates[] | select(.domain.main==\"'example.com'\") | .key' /data/acme.json | base64 -d > /out/tls_key.pem;
```

or

```bash
cat acme/acme.json | head -n {line} | tail -n 1 | cut -d ":" -f 2 | cut -d "\"" -f 2 | base64 --decode > certs/private.pem
cat acme/acme.json | head -n {line} | tail -n 1 | cut -d ":" -f 2 | cut -d "\"" -f 2 | base64 --decode > certs/certificate.pem
```

### Test

Access the unifi at the web address (eg: `unifi.zorab.im`) you have specified in your DNS A record which should match the certfifcate.

### Current config

- Let's Encrypt 
  - Traefik @ Dockerhost
    - /data/compose/81/letsencrypt/acme.json
- Unifi @ 192.168.50.10
- 

### Links

[Unifi Easy Encryt script][def]
Unifi community post forum guide [here][def2]
Extract LE certificate from traefik via docker [here][def3]

[def]: https://get.glennr.nl/unifi/extra/unifi-easy-encrypt.sh
[def2]: https://community.ui.com/questions/UniFi-Installation-Scripts-or-UniFi-Easy-Update-Script-or-UniFi-Lets-Encrypt-or-UniFi-Easy-Encrypt-/ccbc7530-dd61-40a7-82ec-22b17f027776
[def3]: https://www.zdyn.net/docker/2022/02/04/acme-certificate.html