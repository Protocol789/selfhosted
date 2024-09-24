<img src="logo.png" width="300"/>

# Summary 

*Traefik (pronounced traffic) is a modern HTTP reverse proxy and load balancer that makes deploying microservices easy. Traefik integrates with your existing infrastructure components (Docker, Swarm mode, Kubernetes, Consul, Etcd, Rancher v2, Amazon ECS, ...) and configures itself automatically and dynamically. Pointing Traefik at your orchestrator should be the only configuration step you need.*

## Info 

Provides reverse proxying for websites, provieds SSL certificates. 

## Configuration 

| Host                | Install | Config       |
| ------------------- | ------- | ------------ |
| dockerhost01.server | docker  | compose file |

* [x] docker
* [x] docker env variables
* [X] docker volumes
    - [x] folder bind mounts
    - [ ] native docker volume
* [x] Side car config required

config dir: /data/traefik

## How to configure

* Configuration is done via docker labels primarily as per snippet example below. 

[Snippet](dockercompose_snippet.md)

* SSL and certs are peformed via the [readme](SSL_offloading.md).

### Side car config 

Traefik uses the docker host labels to read the configuration from the docker instance. As traefik
is only running on one docker instance, the data needs to be pushed froma a remote instance to
the traefik instance to be able to read it.  

[Traefik-kop ](../software/traefik-kop/README.md) is required to do this 

### Links

[Traefik dashboard](http://dockerhost01.server:8080/dashboard/#/)
[GH Traefik](https://github.com/traefik/traefik)
