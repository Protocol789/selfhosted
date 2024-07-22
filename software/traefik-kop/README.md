# traefik-kop

A dynamic docker->redis->traefik discovery agent.

Solves the problem of running a non-Swarm/Kubernetes multi-host cluster with a
single public-facing traefik instance.

```text
                        +---------------------+          +---------------------+
                        |                     |          |                     |
+---------+     :443    |  +---------+        |   :8088  |  +------------+     |
|   WAN   |--------------->| traefik |<-------------------->| svc-nginx  |     |
+---------+             |  +---------+        |          |  +------------+     |
                        |       |             |          |                     |
                        |  +---------+        |          |  +-------------+    |
                        |  |  redis  |<-------------------->| traefik-kop |    |
                        |  +---------+        |          |  +-------------+    |
                        |             docker1 |          |             docker2 |
                        +---------------------+          +---------------------+
```

## Info

- traefik-kop sits on all the remote dockers and pushes to the redis instance that sits next to 
traefik.
- Redis instance sits locally next to the traefik instance

## Configuration 

| Host           | Install | Config       |
| -------------- | ------- | ------------ |
| All docker hosts | docker  | compose file |

* [x] docker
* [ ] docker volumes
    * [ ] folder bind mounts
    * [ ] native docker volume

## Links

https://github.com/jittering/traefik-kop