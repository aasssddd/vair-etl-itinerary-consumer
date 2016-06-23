# fee-appender.coffee
moment = require 'moment'
FileAppender = require '../file-appender'

class FeeAppender extends FileAppender

	doAppend: (itineraryResult, callback) ->
		if !itineraryResult.Booking.Fees?
			return callback null
		fees = itineraryResult.Booking.Fees[0].Fee
		appendCSV = @appendCSV
		filePath = @filePath
		fileName = @fileName
		updateDate = @dataDate
		fees.forEach (item) ->
			record = []
			record.push item.booking_fee_id[0]
			record.push item.fee_amount[0]
			record.push item.booking_id[0]
			record.push item.agency_code[0]
			record.push item.currency_rcd[0]
			record.push item.acct_fee_amount[0]
			record.push item.change_comment[0]
			record.push item.accounting_add_batch[0]
			record.push item.accounting_void_batch[0]
			record.push item.passenger_id[0]
			record.push item.booking_segment_id[0]
			record.push item.passenger_segment_service_id[0]
			record.push item.fee_id[0]
			record.push item.vat_percentage[0]
			record.push item.charge_amount[0]
			record.push item.charge_currency_rcd[0]
			record.push item.void_by[0]
			record.push moment(item.void_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.account_fee_by[0]
			record.push moment(item.account_fee_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.waive_by[0]
			record.push moment(item.waive_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss" 
			record.push item.create_by[0]
			record.push moment(item.update_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.update_by[0]
			record.push moment(item.create_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.od_origin_rcd[0]
			record.push item.od_destination_rcd[0]
			record.push item.fee_category_rcd[0]
			record.push item.document_number[0]
			record.push moment(item.document_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.comment[0]
			record.push item.external_reference[0]
			record.push item.vendor_rcd[0]
			record.push item.weight_lbs[0]
			record.push item.weight_kgs[0]
			record.push item.number_of_units[0]
			record.push item.units[0]
			record.push item.mpd_number[0]
			record.push item.lastname[0]
			record.push item.firstname[0]
			record.push item.title_rcd[0]
			record.push item.passenger_type_rcd[0]
			record.push item.airline_rcd[0]
			record.push item.flight_number[0]
			record.push item.origin_rcd[0]
			record.push item.destination_rcd[0]
			record.push moment(item.departure_date[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.boarding_class_rcd[0]
			record.push item.booking_class_rcd[0]
			record.push item.passenger_status_rcd[0]
			record.push item.fee_rcd[0]
			record.push item.display_name[0]
			record.push item.language_rcd[0]
			record.push item.payment_amount[0]
			record.push item.user_create[0]
			record.push item.user_update[0]
			record.push item.user_void[0]
			record.push item.user_account[0]
			record.push item.user_waive[0]
			# record.push updateDate
			appendCSV "#{filePath}", "#{fileName}", record, (err) ->
				if err?
					return callback err
		callback null

module.exports = FeeAppender