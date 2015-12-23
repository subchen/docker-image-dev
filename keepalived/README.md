## Getting the container

```bash
docker pull subchen/keepalived
```


## Supported tags

Supported tags and respective `Dockerfile` links

* `1.2`, `latest` ([1.2/Dockerfile](https://github.com/subchen/docker-images/blob/master/keepalived/1.2/Dockerfile))


## Usages

* MASTER

```bash
docker run --rm -it --name keepalived \
  --cap-add=NET_ADMIN \
  -e HAPROXY_SERVERS="10.0.0.11:8080 10.0.0.12:8080" \
  -e KEEPALIVED_VIP="10.0.0.200" \
  subchen/keepalived
```

* BACKUP

```bash
docker run --rm -it --name keepalived-backup \
  --cap-add=NET_ADMIN \
  -e HAPROXY_SERVERS="10.0.0.11:8080 10.0.0.12:8080" \
  -e KEEPALIVED_STATE=BACKUP \
  -e KEEPALIVED_VIP="10.0.0.200" \
  subchen/keepalived
```


## More information

* [GitHub repo](https://github.com/subchen/docker-images/blob/master/keepalived)
* [DockerHub repo](https://hub.docker.com/r/subchen/keepalived)


