#### Sharded Cluster
![Image text](https://raw.githubusercontent.com/lianshufeng/docker_mongo_shard/master/image/sharded-cluster-production-architecture.svg)
#
- reference 
````shell
https://docs.mongodb.com/manual/sharding/
````
- step 1 (key && password)
````shell
# ./tools/makeKeys.sh to keyFile.file
keyFile.file

# .env
MONGO_INITDB_ROOT_USERNAME=root
MONGO_INITDB_ROOT_PASSWORD=8756mongo2021
````

- step 2 (mongo-shard)
````shell
# mongo-shard1/.env
MongoSetsName=MongoSetsShard1
MongoSetsHost=192.168.63.130:30117,192.168.63.130:30118,192.168.63.130:30119

# docker command line
docker-compose -f docker-compose-shard1.yml -f docker-compose-shard2.yml -f docker-compose-shard3.yml up -d

# replSetInitiate
docker exec -it mongo-shard1 bash /opt/mongo/cmd/setup.sh

# client
docker exec -it mongo-shard1 bash /opt/mongo/cmd/client.sh

````

- step 3 (mongo-conf)
````shell
# mongo-conf/.env
MongoSetsHost=192.168.63.130:31017,192.168.63.130:31018,192.168.63.130:31019

# docker command line
docker-compose -f docker-compose-conf1.yml -f docker-compose-conf2.yml -f docker-compose-conf3.yml up -d

# replSetInitiate
docker exec -it mongo-conf1 bash /opt/mongo/cmd/setup.sh

# client
docker exec -it mongo-conf1 bash /opt/mongo/cmd/client.sh
````


- step 4 (mongo-router)
````shell
# mongo-router/.env
MongoSetsConfName=MongoSetsConf
MongoSetsConfHost=192.168.63.130:31017,192.168.63.130:31018,192.168.63.130:31019

# docker command line
docker-compose -f docker-compose-router1.yml -f docker-compose-router2.yml up -d

# addShard
docker exec -it mongo-router1 bash /opt/mongo/cmd/addShard.sh MongoSetsShard1/192.168.63.130:30117,192.168.63.130:30118,192.168.63.130:30119

# client
docker exec -it mongo-router1 bash /opt/mongo/cmd/client.sh

````

- Sharding command line
````shell
# Sharding Status
sh.status();

# Enable Sharding for a Database
sh.enableSharding("<database>")

# Shard a Collection
sh.shardCollection("<database>.<collection>", { <shard key field> : "hashed" | 1 } )

# resharding operation
db.adminCommand({
  reshardCollection: "<database>.<collection>",
  key: <shardkey>
})
````

- eq
````shell
# client
docker exec -it mongo-router1 bash /opt/mongo/cmd/client.sh

# Enable Sharding for a Database
sh.enableSharding("message")

# create index
use message
db.person.createIndex({"age":1})

# shardCollection
sh.shardCollection("message.person", { "age" : "hashed" } )

# insert records
use message
db.person.insert({"age":1})
db.person.insert({"age":2})
db.person.insert({"age":3})
db.person.insert({"age":4})
db.person.insert({"age":5})
db.person.insert({"age":6})
db.person.insert({"age":7})
db.person.insert({"age":8})
db.person.insert({"age":9})


# Refine Shard Key
db.adminCommand( {
   refineCollectionShardKey: "message.person",
   key: { customer_id: 1, order_id: 1 }
} )

# resharding (about 5 minutes)
db.adminCommand({
  reshardCollection: "message.person",
  key: { "age" : "hashed" }
})


# Monitor Resharding 
db.getSiblingDB("admin").aggregate([
  { $currentOp: { allUsers: true, localOps: false } },
  {
    $match: {
      type: "op",
      "originatingCommand.reshardCollection": "message.person"
    }
  }
])

````
