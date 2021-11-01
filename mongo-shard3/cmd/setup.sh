#!/bin/bash 

#加载环境变量
set -o allexport
source /.env
set +o allexport

echo "replSetInitiate..."
#初始化集群
mongosh --shell $ScriptPath/replSetInitiate.js

#初始化权限
echo "initRootUser..."
mongosh --shell $ScriptPath/initRootUser.js