# taxAppender.coffee
FileAppender = require '../file-appender'
moment = require 'moment'

class TaxAppender extends FileAppender
	doAppend: (itineraryResult, callback) ->
		
		if !itineraryResult.Booking.TicketTaxes?
			return callback null
		updateDate = @dataDate
		appendCSV = @appendCSV
		filePath = @filePath
		fileName = @fileName
		ticketTax = itineraryResult.Booking.TicketTaxes[0].Tax
		ticketTax.forEach (item) ->
			record = []
			record.push item.passenger_segment_tax_id[0]
			record.push item.tax_amount[0]
			record.push item.acct_amount[0]
			record.push item.sales_amount[0]
			record.push item.vat_percentage[0]
			record.push item.tax_rcd[0]
			record.push item.accounting_add_batch[0]
			record.push item.accounting_void_batch[0]
			record.push moment(item.void_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.void_by[0]
			record.push item.create_by[0]
			record.push moment(item.create_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.update_by[0]
			record.push moment(item.update_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.passenger_id[0]
			record.push item.tax_id[0]
			record.push item.booking_segment_id[0]
			record.push item.tax_currency_rcd[0]
			record.push item.sales_currency_rcd[0]
			record.push item.display_name[0]
			record.push item.summarize_up[0]
			record.push item.coverage_type[0]
			record.push item.passenger_type_rcd[0]
			record.push updateDate
			appendCSV filePath, fileName, record, (err) ->
				if err?
					return callback err
		callback null


module.exports = TaxAppender