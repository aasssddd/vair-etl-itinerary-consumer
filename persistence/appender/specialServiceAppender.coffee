# specialServiceAppender.coffee
FileAppender = require '../file-appender'
moment = require 'moment'

class SpecialServiceAppender extends FileAppender
	doAppend: (itineraryResult, callback) ->
		updateDate = @dataDate
		appendCSV = @appendCSV
		filePath = @filePath
		fileName = @fileName

		if !itineraryResult.Booking.SpecialServices?
			return callback null

		special = itineraryResult.Booking.SpecialServices[0].SpecialService
		special.forEach (item) ->
			record = []
			record.push item.passenger_segment_service_id[0]
			record.push item.passenger_id[0]
			record.push item.booking_segment_id[0]
			record.push item.special_service_rcd[0]
			record.push item.service_text[0]
			record.push item.unit_rcd[0]
			record.push item.number_of_units[0]
			record.push item.special_service_status_rcd[0]
			record.push item.special_service_change_status_rcd[0]
			record.push item.create_by[0]
			record.push moment(item.create_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.update_by[0]
			record.push moment(item.update_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.lastname[0]
			record.push item.firstname[0]
			record.push item.passenger_type_rcd[0]
			record.push item.title_rcd[0]
			record.push item.booking_class_rcd[0]
			record.push item.boarding_class_rcd[0]
			record.push item.airline_rcd[0]
			record.push item.flight_number[0]
			record.push item.marketing_airline_rcd[0]
			record.push item.marketing_flight_number[0]
			record.push item.origin_rcd[0]
			record.push item.destination_rcd[0]
			record.push moment(item.departure_date[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.display_name[0]
			record.push item.create_name[0]
			record.push item.update_name[0]
			record.push item.help_text[0]
			record.push item.special_service_status[0]
			record.push updateDate
			appendCSV filePath, fileName, record, (err) ->
				if err?
					return callback err
		callback null

module.exports = SpecialServiceAppender