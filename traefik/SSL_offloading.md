# Summary

SSL is performed via Traefik and the letencrypt service

## Configuration 

Lets encrypt handles the certs for us via [DNS challenge ][def] feature. 

* CF credentials are stored in docker env variables
* Main config is peformed in the docker compose yaml file

## KNOWN ISSUES

* xxx

### Config snippet 

```yaml
      - "--certificatesresolvers.cloudflare.acme.dnschallenge=true"
      - "--certificatesresolvers.cloudflare.acme.dnschallenge.provider=cloudflare"
      # - "--certificatesresolvers.cloudflare.acme.caserver=https://acme-staging-v02.api.letsencrypt.org/directory"    # STAGING API
      - "--certificatesresolvers.cloudflare.acme.email=postmaster@zorab.im"
      - "--certificatesresolvers.cloudflare.acme.storage=/letsencrypt/acme.json
```

### Links

How Lets Encrypt [DNS-01 challenge][def2] works 

[def]: https://doc.traefik.io/traefik/user-guides/docker-compose/acme-dns/
[def2]: https://letsencrypt.org/docs/challenge-types/
