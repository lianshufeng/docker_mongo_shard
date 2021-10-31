let username = process.env['MONGO_INITDB_ROOT_USERNAME'];
let password = process.env['MONGO_INITDB_ROOT_PASSWORD'];

//切换admin库
db = db.getSiblingDB('admin');
//创建root角色的账号和密码 
db.createUser({
    user: username,
    pwd: password,
    roles: [{
        'role': 'root',
        'db': 'admin'
    }]
})
//退出
quit()