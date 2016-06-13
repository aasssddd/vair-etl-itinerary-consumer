# remarkAppender.coffee
FileAppender = require '../file-appender'
moment = require 'moment'

class RemarkAppender extends FileAppender
	doAppend: (itineraryResult, callback) ->
		if !itineraryResult.Booking.Remarks? 
			# console.log "no remark data"
			return callback null
		updateDate = @dataDate
		appendCSV = @appendCSV
		filePath = @filePath
		fileName = @fileName
		remark = itineraryResult.Booking.Remarks[0].Remark
		remark.forEach (item) ->
			if item.remark_text[0] != "AUTO IGNORE TLT REACHED - BOOKING CANCELLED"
				record = []
				record.push item.booking_remark_id[0]
				record.push item.client_profile_id[0]
				record.push item.remark_type_rcd[0]
				record.push moment(item.timelimit_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
				record.push item.complete_flag[0]
				record.push item.process_message_flag[0]
				record.push item.remark_text[0]
				record.push item.create_by[0]
				record.push moment(item.create_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
				record.push item.update_by[0]
				record.push moment(item.update_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
				record.push item.booking_id[0]
				record.push item.split_booking_id[0]
				record.push item.added_by[0]
				record.push item.agency_code[0]
				record.push item.display_name[0]
				record.push item.create_name[0]
				record.push item.update_name[0]
				record.push updateDate
				appendCSV filePath, fileName, record, (err) ->
				if err?
					return callback err
		callback null

module.exports = RemarkAppender