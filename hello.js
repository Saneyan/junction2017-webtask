const pg = require('pg')

const pool = new pg.Pool({
  connectionString: 'postgres://admin:EURIMSYUKRXXYNAC@gcp-europe-west1-cpu.2.dblayer.com:16318/compose'
})

module.exports = function (cb) {
  pool.query('SELECT NOW()', (err, res) => {
    // pool.end()
    cb(null, res);
  })
}
