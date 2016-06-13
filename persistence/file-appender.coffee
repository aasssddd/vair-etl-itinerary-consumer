# file-appender.coffee
fs = require 'graceful-fs'
path = require 'path'
moment = require 'moment'


class FileAppender
	dataDate: new moment().format "YYYY/MM/DD"
	constructor: (@filePath, @fileName) ->

	appendCSV: (filePath, fileName, recordList, callback) ->
		fs.appendFile "#{path.resolve filePath, fileName}", recordList.join('㊣') + "\r\n", (err) ->
			return callback err

	append: (itineraryResult, appender, callback) ->
		appendCSV = @appendCSV
		dataDate = @dataDate
		appender.doAppend itineraryResult, (err) ->
			if err?
				return callback err
			return callback null

	doAppend: (itineraryResult, callback) ->

module.exports = FileAppender