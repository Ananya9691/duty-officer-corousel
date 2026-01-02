const oracledb = require('oracledb');

oracledb.outFormat = oracledb.OUT_FORMAT_OBJECT;

async function getConnection() {
    return await oracledb.getConnection({
        user: "C##DUTY",
        password: "duty123",
        connectString: "localhost:1521/ORCLPDB"
    });
}

module.exports = {
    getConnection
};
