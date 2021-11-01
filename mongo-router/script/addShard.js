let shardHost = process.env['shardHost'];
sh.addShard( shardHost );

//查看状态
sh.status();
quit();