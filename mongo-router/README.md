
- 防火墙
````shell
sudo firewall-cmd --add-port=27017/tcp --permanent
sudo firewall-cmd --add-port=27018/tcp --permanent
firewall-cmd --reload 
````

- 挂载
````shell
rm -rf ./store
mkdir -p ./store/data/mongo1  ./store/data/mongo2  
chmod -R 777 ./store/data/mongo1 ./store/data/mongo2 
````


- 启动容器
````shell

# 关闭
docker-compose -f docker-compose-router1.yml -f docker-compose-router2.yml down  

# 启动
docker-compose -f docker-compose-router1.yml -f docker-compose-router2.yml up -d

````


- 添加分片
````shell
docker exec -it mongo-router1 bash /opt/mongo/cmd/addShard.sh MongoSetsShard1/192.168.63.130:30117,192.168.63.130:30118,192.168.63.130:30119
docker exec -it mongo-router1 bash /opt/mongo/cmd/addShard.sh MongoSetsShard2/192.168.63.130:30217,192.168.63.130:30218,192.168.63.130:30219

#docker exec -it mongo-router1 bash /opt/mongo/cmd/addShard.sh MongoSetsShard3/192.168.63.130:30317,192.168.63.130:30318,192.168.63.130:30319

````





