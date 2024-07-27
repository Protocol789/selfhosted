# Uptime Kuma

<img src="logo.svg" width="300"/>

Uptime Kuma is an easy-to-use self-hosted monitoring tool.

## Configuration 

| Host           | Install | Config       |
| -------------- | ------- | ------------ |
| [frontend.server][fe] | docker  | compose file |

* [x] docker
* [x] docker env variables
* [x] docker volumes
    * [ ] folder bind mounts
    * [x] native docker volume
    * [x] side car software
* [x] Open API

## Info

## Side car software

### Uptime-Kuma-Web-API

#### A REST API wrapper for [Uptime Kuma](https://github.com/louislam/uptime-kuma) using [Uptime-Kuma-API](https://github.com/lucasheld/uptime-kuma-api)


Rest API credentials can be found in **stack.env**

```bash
TOKEN=$(curl -X -L 'POST' -H 'Content-Type: application/x-www-form-urlencoded' --data 'username=admin&password={passwordfromcompose}' http://127.0.0.1:8000/login/access-token/ | jq -r ".access_token")

curl -L -H 'Accept: application/json' -H "Authorization: Bearer ${TOKEN}" http://127.0.0.1:8000/monitors/
``` 

### Links

[Uptime Kuma](https://github.com/louislam/uptime-kuma)  
[Uptime Kuma Web API](https://github.com/MedAziz11/Uptime-Kuma-Web-API/blob/main/README.md)
  

[be]: https://portainer.zorab.im/#!/2/docker/stacks
[fe]: https://portainer.zorab.im/#!/3/docker/stacks