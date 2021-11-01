#!/bin/bash 

#加载环境变量
set -o allexport
source /.env
set +o allexport


export shardHost=$1
echo "shardHost : "$shardHost


#添加分片,使用配置的账号和密码
mongosh -u $MONGO_INITDB_ROOT_USERNAME -p $MONGO_INITDB_ROOT_PASSWORD --shell $ScriptPath/addShard.js