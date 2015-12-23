## Getting the container

```bash
docker pull subchen/haproxy
```


## Supported tags

Supported tags and respective `Dockerfile` links

* `1.5`, `latest` ([1.5/Dockerfile](https://github.com/subchen/docker-images/blob/master/haproxy/1.5/Dockerfile))


## Usages

* Use default `/etc/haproxy/haproxy.cfg`

```bash
docker run --rm -it --name haproxy \
  -p 80:80 \
  -e HAPROXY_SERVERS="172.16.1.21:8080 172.16.1.22:8080" \
  haproxy
```

* Use customized `/etc/haproxy/haproxy.cfg`

```bash
docker run --rm -it --name haproxy \
  -p 80:80 \
  -v haproxy.cfg:/etc/haproxy/haproxy.cfg:ro \
  haproxy
```


## More information

* [GitHub repo](https://github.com/subchen/docker-images/blob/master/haproxy)
* [DockerHub repo](https://hub.docker.com/r/subchen/haproxy)

