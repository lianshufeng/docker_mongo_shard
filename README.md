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
# copy mongo-shard1 to mongo-shard1 && mongo-shard2
# mongo-shard1/.env
MongoSetsName=MongoSetsShard1
MongoSetsHost=192.168.63.130:30017,192.168.63.130:30018,192.168.63.130:30019

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
docker exec -it mongo-router1 bash /opt/mongo/cmd/addShard.sh MongoSetsShard1/192.168.63.130:30017,192.168.63.130:30018,192.168.63.130:30019

# client
docker exec -it mongo-router1 bash /opt/mongo/cmd/client.sh

````

- command line
````shell
# Sharding Status
sh.status();

# Enable Sharding for a Database
sh.enableSharding("<database>")

# Shard a Collection
sh.shardCollection("<database>.<collection>", { <shard key field> : "hashed" } )

````
