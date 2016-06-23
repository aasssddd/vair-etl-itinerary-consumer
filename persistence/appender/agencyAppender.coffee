# agencyAppender.coffee

FileAppender = require '../file-appender'
moment = require 'moment'

class AgencyAppender extends FileAppender
	doAppend: (itineraryResult, callback) ->
		if !itineraryResult.Booking.Header?
			return callback null
		updateDate = @dataDate
		appendCSV = @appendCSV
		filePath = @filePath
		fileName = @fileName
		record = []
		header = itineraryResult.Booking.Header[0].BookingHeader[0]
		record.push header.agency_code[0]
		record.push header.company_name[0]
		record.push header.agency_type_code[0]
		record.push header.legal_name[0]
		record.push header.agency_name[0]
		record.push header.agency_address_line1[0]
		record.push header.agency_address_line2[0]
		record.push header.agency_street[0]
		record.push header.agency_po_box[0]
		record.push header.agency_city[0]
		record.push header.agency_zip_code[0]
		record.push header.agency_province[0]
		record.push header.agency_state[0]
		record.push header.agency_country_rcd[0]
		record.push header.agency_tax_id[0]
		record.push header.own_agency_flag[0]
		record.push header.web_agency_flag[0]
		record.push header.agency_email[0]
		record.push header.disable_changes_through_b2c_flag[0]
		record.push header.disable_web_checkin_flag[0]
		record.push header.api_flag[0]
		record.push header.agency_country_name[0]
		record.push header.iata_number[0]
		appendCSV filePath, fileName, record, (err) ->
			if err?
				return callback err
		callback null

module.exports = AgencyAppender