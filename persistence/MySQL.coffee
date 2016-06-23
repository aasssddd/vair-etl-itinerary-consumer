mysql = require 'mysql'
config = require '../config'

class MySQL

	constructor: () ->
		@pool = mysql.createPool {
			host: config.mysql.host,
			user: config.mysql.user,
			password: config.mysql.password,
			database: config.mysql.database,
			connectionLimit: config.mysql.poolSize,
			waitForConnections: true,
			acquireTimeout: 600000
		}
		@pool.on 'enqueue', () ->
			console.log "waiting for available connection slot"
		.on 'connection', (connection) ->
			console.log "connection created"

	loadData: (fileFullPath, tableName, callback) ->
		strSql = "LOAD DATA LOCAL INFILE '#{fileFullPath}' REPLACE INTO TABLE #{tableName} FIELDS TERMINATED BY '㊣' LINES TERMINATED BY '\r\n' SET db_update_date=CURRENT_TIMESTAMP"
		console.log strSql  

		# @pool.query strSql, (err, data) ->
		@pool.getConnection (err, conn) ->
			if err?
				console.log "get connection fail: #{err}"
				return callback err

			conn.query strSql, (err, data) ->
				if err?
					console.log "quer error : #{err}"
					return callback err
				conn.release()
				callback err

	close: () ->
		@pool.end()

module.exports = MySQL

