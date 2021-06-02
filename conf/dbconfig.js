/*  DB Info */

module.exports = 
{
    user : process.env.NODE_ORACLEDB_USER || "cinema",
    password : process.env.NODE_ORACLEDB_PASSWOR || "123456",
    connectString : process.env.NODE_ORACLEDB_CONNECTIONSTRING || "localhost/xe"
}


// module.exports = {
//     user : process.env.NODE_ORACLEDB_USER || "계정아이디",
    
//     // Instead of hard coding the password, consider prompting for it,
//     // passing it in an environment variable via process.env, or using
//     // External Authentication.
//     password : process.env.NODE_ORACLEDB_PASSWORD || "비밀번호",
    
//     // For information on connection strings see:
//     // https://github.com/oracle/node-oracledb/blob/master/doc/api.md#connectionstrings
//     connectString : process.env.NODE_ORACLEDB_CONNECTIONSTRING || "호스트이름/자신의 sid",
    
    
//     // Setting externalAuth is optional. It defaults to false. See:
//     // https://github.com/oracle/node-oracledb/blob/master/doc/api.md#extauth
//     externalAuth : process.env.NODE_ORACLEDB_EXTERNALAUTH ? true : false
//     };