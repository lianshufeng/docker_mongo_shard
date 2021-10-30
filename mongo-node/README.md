
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

- 初始化集群 (replSetInitiate)
````shell
docker exec -it mongo-node1 bash /opt/mongo/cmd/setup.sh
````