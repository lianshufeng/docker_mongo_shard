//集群名
let mongoSetsName = process.env['MongoSetsName'];

//集群成员
let members = [];
let mongoSetsHost = process.env['MongoSetsHost'];
let items = mongoSetsHost.split(',');
for(let i in items){
	members.push({
		'_id': parseInt(i) ,
		'host': items[i]
	});
}

//切换admin库
db = db.getSiblingDB('admin');

//配置集群
cfg = {
	'configsvr' : true,
    '_id' : mongoSetsName,
    'members' : members
};


//初始化
rs.initiate(cfg, { force: true });
rs.reconfig(cfg, { force: true });

//退出
quit()