# passengerAppender.coffee
FileAppender = require '../file-appender'
moment = require 'moment'

class PassengerAppender extends FileAppender
	doAppend: (itineraryResult, callback) ->
		if !itineraryResult.Booking.Passengers?
			# console.log "no passenger data"
			return callback null
		updateDate = @dataDate
		appendCSV = @appendCSV
		filePath = @filePath
		fileName = @fileName
		passengers = itineraryResult.Booking.Passengers[0].Passenger
		passengers.forEach (item) ->
			record = []
			record.push item.passenger_id[0]
			record.push item.booking_id[0]
			record.push item.guardian_passenger_id[0]
			record.push item.passenger_type_rcd[0]
			record.push item.lastname[0]
			record.push item.firstname[0]
			record.push item.middlename[0]
			record.push moment(item.date_of_birth[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.title_rcd[0]
			record.push item.create_by[0]
			record.push moment(item.create_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.update_by[0]
			record.push moment(item.update_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.gender_type_rcd[0]
			record.push item.client_number[0]
			record.push item.member_number[0]
			record.push item.member_airline_rcd[0]
			record.push item.member_level_rcd[0]
			record.push item.nationality_rcd[0]
			record.push item.nationality_display_name[0]
			record.push item.residence_country_rcd[0]
			record.push item.document_type_rcd[0]
			record.push item.passport_number[0]
			record.push moment(item.passport_issue_date[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push moment(item.passport_expiry_date[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.passport_issue_place[0]
			record.push item.passport_issue_country_rcd[0]
			record.push item.passport_issue_country_display_name[0]
			record.push item.passport_birth_place[0]
			record.push item.wheelchair_flag[0]
			record.push item.vip_flag[0]
			record.push item.passenger_weight[0]
			record.push item.passenger_type[0]
			record.push item.title[0]
			record.push item.gender_type[0]
			record.push item.create_name[0]
			record.push item.update_name[0]
			record.push updateDate
			appendCSV filePath, fileName, record, (err) ->
				if err?
					return callback err
		callback null

module.exports = PassengerAppender