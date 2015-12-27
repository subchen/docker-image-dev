## Getting the container

```bash
docker pull subchen/mongodb
```


## Supported tags

Supported tags and respective `Dockerfile` links

* `3.2`, `latest` ([3.2/Dockerfile](https://github.com/subchen/docker-images/blob/master/mongodb/3.2/Dockerfile))


## Usages

Single Mode

```bash
docker run --rm -it --name mongodb \
  -p 27017:27017 \
  subchen/mongodb
```

Replicate Set

```bash
# start 3 servers
docker run -d -it --name mongo-server-1 mongo mongod --replSet repset
docker run -d -it --name mongo-server-2 mongo mongod --replSet repset
docker run -d -it --name mongo-server-3 mongo mongod --replSet repset

# init replSet
docker exec -it mongo-server-1 mongo $(docker inspect -f "{{ .NetworkSettings.IPAddress }}" mongo-server-1):27017
mongo > rs.initiate({
    "_id" : "repset",
    "members" : [
        { "_id" : 0, "host" : "172.17.0.100:27017" },
        { "_id" : 1, "host" : "172.17.0.101:27017" },
        { "_id" : 2, "host" : "172.17.0.102:27017", arbiterOnly:true }
    ]
});
```

Shard Mode with Replicate Set

```bash
# start 3 config servers
docker run -d -it --name mongo-configsrv-1 mongodb mongod --configsvr
docker run -d -it --name mongo-configsrv-2 mongodb mongod --configsvr
docker run -d -it --name mongo-configsrv-3 mongodb mongod --configsvr

# start 3 mongos servers
docker run -d -it --name mongos-1 mongodb mongos --configdb "172.17.0.97:27019,172.17.0.98:27019,172.17.0.99:27019"
docker run -d -it --name mongos-2 mongodb mongos --configdb "172.17.0.97:27019,172.17.0.98:27019,172.17.0.99:27019"
docker run -d -it --name mongos-3 mongodb mongos --configdb "172.17.0.97:27019,172.17.0.98:27019,172.17.0.99:27019"

# start 3x3 mongo replset servers
docker run -d -it --name mongo-repsetsvr-1-1 mongodb mongod --repsetsvr --replSet shard1
docker run -d -it --name mongo-repsetsvr-1-2 mongodb mongod --repsetsvr --replSet shard1
docker run -d -it --name mongo-repsetsvr-1-3 mongodb mongod --repsetsvr --replSet shard1
docker run -d -it --name mongo-repsetsvr-2-1 mongodb mongod --repsetsvr --replSet shard2
docker run -d -it --name mongo-repsetsvr-2-2 mongodb mongod --repsetsvr --replSet shard2
docker run -d -it --name mongo-repsetsvr-2-3 mongodb mongod --repsetsvr --replSet shard2
docker run -d -it --name mongo-repsetsvr-3-1 mongodb mongod --repsetsvr --replSet shard3
docker run -d -it --name mongo-repsetsvr-3-2 mongodb mongod --repsetsvr --replSet shard3
docker run -d -it --name mongo-repsetsvr-3-3 mongodb mongod --repsetsvr --replSet shard3

# init repset shard1
docker run --rm -it subchen/mongodb mongo $(docker inspect -f "{{ .NetworkSettings.IPAddress }}" mongo-repsetsvr-1-1):27018
mongo > use admin
mongo > rs.initiate({
    "_id" : "shard1",
    "members" : [
        { "_id" : 0, "host" : "172.17.0.101:27018" },
        { "_id" : 1, "host" : "172.17.0.102:27018" },
        { "_id" : 2, "host" : "172.17.0.103:27018", arbiterOnly:true }
    ]
});

# init repset shard2
docker run --rm -it subchen/mongodb mongo $(docker inspect -f "{{ .NetworkSettings.IPAddress }}" mongo-repsetsvr-2-1):27018
mongo > use admin
mongo > rs.initiate({
    "_id" : "shard2",
    "members" : [
        { "_id" : 0, "host" : "172.17.0.104:27018" },
        { "_id" : 1, "host" : "172.17.0.105:27018" },
        { "_id" : 2, "host" : "172.17.0.106:27018", arbiterOnly:true }
    ]
});

# init repset shard3
docker run --rm -it subchen/mongodb mongo $(docker inspect -f "{{ .NetworkSettings.IPAddress }}" mongo-repsetsvr-3-1):27018
mongo > use admin
mongo > rs.initiate({
    "_id" : "shard3",
    "members" : [
        { "_id" : 0, "host" : "172.17.0.107:27018" },
        { "_id" : 1, "host" : "172.17.0.108:27018" },
        { "_id" : 2, "host" : "172.17.0.109:27018", arbiterOnly:true }
    ]
});

# init shard
docker run --rm -it subchen/mongodb mongo $(docker inspect -f "{{ .NetworkSettings.IPAddress }}" mongos-1):27017
mongo > use admin
mongo > db.runCommand( { addshard : "shard1/172.17.0.101:27018,172.17.0.102:27018,172.17.0.103:27018"});
mongo > db.runCommand( { addshard : "shard2/172.17.0.104:27018,172.17.0.105:27018,172.17.0.106:27018"});
mongo > db.runCommand( { addshard : "shard3/172.17.0.107:27018,172.17.0.108:27018,172.17.0.109:27018"});
mongo > db.runCommand( { listshards : 1 } );

# set shard for db/collection
mongo > use admin
mongo > db.runCommand( { enablesharding: "testdb"});
mongo > db.runCommand( { shardcollection: "testdb.table1", key: {id: 1} } )
```


## More information

* [GitHub repo](https://github.com/subchen/docker-images/blob/master/mongodb)
* [DockerHub repo](https://hub.docker.com/r/subchen/mongodb)

