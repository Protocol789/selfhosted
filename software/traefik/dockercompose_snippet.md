```yml
    labels:
     - "traefik.enable=true"
     - "traefik.docker.network=traefik_public"     
     - "traefik.http.routers.photos.rule=Host(`photos.zorab.im`)"
#     - "traefik.http.routers.photos.entrypoints=websecure"
     - "traefik.http.routers.photos.tls.domains[0].main=zorab.im"
     - "traefik.http.routers.photos.tls.domains[0].sans=*.zorab.im"
     - "traefik.http.routers.photos.tls.certResolver=cloudflare"   
```