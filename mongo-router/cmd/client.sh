#!/bin/bash 

#刷新环境变量
source /.env


#启动
mongosh -u $MONGO_INITDB_ROOT_USERNAME -p $MONGO_INITDB_ROOT_PASSWORD