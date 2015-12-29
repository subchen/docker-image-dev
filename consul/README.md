## Getting the container

```bash
docker pull subchen/consul
```


## Supported tags

Supported tags and respective `Dockerfile` links

* `0.6.0`, `latest` ([0.6.0/Dockerfile](https://github.com/subchen/docker-images/blob/master/consul/0.6.0/Dockerfile))


## Usages

* Use default configs in  `/etc/consul.d/`

```bash
docker run -d -p 8400:8400 -p 8500:8500 -p 53:8600/udp --name consul-server subchen/consul
```

* consul clusters

```bash
# 3 servers
docker run -d --name node1 subchen/consul \
  consul agent -server -bootstrap-expect=3 -data-dir=/data

docker run -d --name node2 subchen/consul \
  consul agent -server -bootstrap-expect=3 -data-dir=/data -join=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' node1)

docker run -d --name node3 subchen/consul \
  consul agent -server -bootstrap-expect=3 -data-dir=/data -join=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' node1)

# 1 client
docker run -d -p 8400:8400 -p 8500:8500 -p 53:8600/udp --name node4 subchen/consul \
  consul agent -client=0.0.0.0 -data-dir=/data -ui-dir=/ui -join=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' node1)
```

* test cluser using `docker-compose.yml`

```
node1:
  image: subchen/consul
  command: consul agent -server -bootstrap-expect=3 -data-dir=/data

node2:
  image: subchen/consul
  command: consul agent -server -bootstrap-expect=3 -data-dir=/data -join=node1
  links:
    - node1

node3:
  image: subchen/consul
  command: consul agent -server -bootstrap-expect=3 -data-dir=/data -join=node1
  links:
    - node1

node4:
  image: subchen/consul
  command: consul agent -client=0.0.0.0 -data-dir=/data -ui-dir=/ui -join=node1
  links:
    - node1
  ports:
    - 8400:8400
    - 8500:8500
    - 53:8600/udp
  dns:
    - 127.0.0.1
```

* validate

```bash
curl localhost:8500/v1/catalog/nodes

dig @127.0.0.1 -p 53 node1.node.consul
```


## More information

* [GitHub repo](https://github.com/subchen/docker-images/blob/master/consul)
* [DockerHub repo](https://hub.docker.com/r/subchen/consul)

