
- 防火墙
````shell
sudo firewall-cmd --add-port=30217/tcp --permanent
sudo firewall-cmd --add-port=30218/tcp --permanent
sudo firewall-cmd --add-port=30219/tcp --permanent
firewall-cmd --reload 
````

- 挂载
````shell
rm -rf ./store
mkdir -p ./store/data/mongo1  ./store/data/mongo2  ./store/data/mongo3
chmod -R 777 ./store/data/mongo1 ./store/data/mongo2 ./store/data/mongo3
````


- 启动容器
````shell

# 关闭
docker-compose -f docker-compose-shard1.yml -f docker-compose-shard2.yml -f docker-compose-shard3.yml down  

# 启动
docker-compose -f docker-compose-shard1.yml -f docker-compose-shard2.yml -f docker-compose-shard3.yml up -d

````


- 初始化集群
````shell
docker exec -it mongo-shard1-2 bash /opt/mongo/cmd/setup.sh
````

- 客户端
````shell
docker exec -it mongo-shard1-2 bash /opt/mongo/cmd/client.sh
````