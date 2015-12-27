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
docker run -d --name mongo-svr-1 subchen/mongodb mongod --replSet repset
docker run -d --name mongo-svr-2 subchen/mongodb mongod --replSet repset
docker run -d --name mongo-svr-3 subchen/mongodb mongod --replSet repset

# init replSet
docker run --rm -it subchen/mongodb mongo $(docker inspect -f "{{ .NetworkSettings.IPAddress }}" mongo-svr-1):27017
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
docker run -d --name mongo-configsvr-1 subchen/mongodb mongod --configsvr
docker run -d --name mongo-configsvr-2 subchen/mongodb mongod --configsvr
docker run -d --name mongo-configsvr-3 subchen/mongodb mongod --configsvr

# start 3 mongos servers
MONGO_CFG_SVR_IP_1=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" mongo-configsvr-1)
MONGO_CFG_SVR_IP_2=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" mongo-configsvr-2)
MONGO_CFG_SVR_IP_3=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" mongo-configsvr-3)
MONGO_CFG_SVR_LIST="$MONGO_CFG_SVR_IP_1:27019,$MONGO_CFG_SVR_IP_2:27019,$MONGO_CFG_SVR_IP_3:27019"

docker run -d --name mongos-1 subchen/mongodb mongos --configdb "$MONGO_CFG_SVR_LIST"
docker run -d --name mongos-2 subchen/mongodb mongos --configdb "$MONGO_CFG_SVR_LIST"
docker run -d --name mongos-3 subchen/mongodb mongos --configdb "$MONGO_CFG_SVR_LIST"

# start 3x3 mongo shard servers
docker run -d --name mongo-shardsvr-1-1 subchen/mongodb mongod --shardsvr --replSet shard1
docker run -d --name mongo-shardsvr-1-2 subchen/mongodb mongod --shardsvr --replSet shard1
docker run -d --name mongo-shardsvr-1-3 subchen/mongodb mongod --shardsvr --replSet shard1
docker run -d --name mongo-shardsvr-2-1 subchen/mongodb mongod --shardsvr --replSet shard2
docker run -d --name mongo-shardsvr-2-2 subchen/mongodb mongod --shardsvr --replSet shard2
docker run -d --name mongo-shardsvr-2-3 subchen/mongodb mongod --shardsvr --replSet shard2
docker run -d --name mongo-shardsvr-3-1 subchen/mongodb mongod --shardsvr --replSet shard3
docker run -d --name mongo-shardsvr-3-2 subchen/mongodb mongod --shardsvr --replSet shard3
docker run -d --name mongo-shardsvr-3-3 subchen/mongodb mongod --shardsvr --replSet shard3

# init repset shard1
docker run --rm -it subchen/mongodb mongo $(docker inspect -f "{{ .NetworkSettings.IPAddress }}" mongo-shardsvr-1-1):27018
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
docker run --rm -it subchen/mongodb mongo $(docker inspect -f "{{ .NetworkSettings.IPAddress }}" mongo-shardsvr-2-1):27018
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
docker run --rm -it subchen/mongodb mongo $(docker inspect -f "{{ .NetworkSettings.IPAddress }}" mongo-shardsvr-3-1):27018
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

