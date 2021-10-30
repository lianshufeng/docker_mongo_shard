#!/bin/bash

#载入环境变量
source /.env

#连接客户端
mongosh --host MongoSets/$MongoSetsHost admin -u ${MONGO_INITDB_ROOT_USERNAME} -p ${MONGO_INITDB_ROOT_PASSWORD}