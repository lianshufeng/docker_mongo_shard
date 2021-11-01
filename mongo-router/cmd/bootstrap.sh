#!/bin/bash 

#刷新环境变量
source /.env



#拷贝密钥
rm -rf $KeyStore/keyfile
mkdir -p $KeyStore/
cp /keyfile.tmp $KeyStore/keyfile
chmod -R 400 $KeyStore/keyfile

#初始化日志文件
mkdir -p $StorePath/logs
echo "" >> $StorePath/logs/mongo.log



#启动
mongos --config $ConfPath/mongo_router.conf --configdb $MongoSetsConfName/$MongoSetsConfHost 