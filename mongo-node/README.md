
- 防火墙
````shell
sudo firewall-cmd --add-port=30017/tcp --permanent
sudo firewall-cmd --add-port=30018/tcp --permanent
sudo firewall-cmd --add-port=30019/tcp --permanent
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
docker-compose -f docker-compose-node1.yml -f docker-compose-node2.yml -f docker-compose-node3.yml down  

# 启动
docker-compose -f docker-compose-node1.yml -f docker-compose-node2.yml -f docker-compose-node3.yml up -d

````


- 初始化集群 (replSetInitiate)
````shell
docker exec -it mongo-node1 bash /opt/mongo/cmd/setup.sh
````

- 客户端
````shell
docker exec -it mongo-node1 bash /opt/mongo/cmd/client.sh
````