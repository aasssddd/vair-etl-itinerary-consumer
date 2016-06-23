# paymentAppender.coffee
FileAppender = require '../file-appender'
moment = require 'moment'

class PaymentAppender extends FileAppender
	doAppend: (itineraryResult, callback) ->
		if !itineraryResult.Booking.Payments?
			# console.log "no payment data"
			return callback null
		updateDate = @dataDate
		appendCSV = @appendCSV
		filePath = @filePath
		fileName = @fileName
		payment = itineraryResult.Booking.Payments[0].Payment
		payment.forEach (item) ->
			record = []
			record.push item.booking_payment_id[0]
			record.push item.booking_id[0]
			record.push item.form_of_payment_rcd[0]
			record.push item.currency_rcd[0]
			record.push item.payment_amount[0]
			record.push item.fee_amount[0]
			record.push item.acct_payment_amount[0]
			record.push item.payment_by[0]
			record.push moment(item.payment_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push moment(item.payment_due_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.document_number[0]
			record.push item.payment_number[0]
			record.push item.approval_code[0]
			record.push item.expiry_month[0]
			record.push item.expiry_year[0]
			record.push item.name_on_card[0]
			record.push item.due_date_flag[0]
			record.push item.document_amount[0]
			record.push item.form_of_payment_subtype_rcd[0]
			record.push moment(item.issue_date[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.payment_remark[0]
			record.push item.issue_by[0]
			record.push item.create_by[0]
			record.push moment(item.create_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.update_by[0]
			record.push moment(item.update_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.void_by[0]
			record.push moment(item.void_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.booking_reference[0]
			record.push item.agency_code[0]
			record.push item.debit_agency_code[0]
			record.push item.form_of_payment[0]
			record.push item.form_of_payment_subtype[0]
			record.push item.ticket_booking_id[0]
			record.push item.void_name[0]
			record.push item.create_name[0]
			record.push item.update_name[0]
			record.push item.payment_reference[0]
			# record.push updateDate
			appendCSV filePath, fileName, record, (err) ->
				if err?
					return callback err
		callback null

module.exports = PaymentAppender