# bookingHeaderAppender.coffee

FileAppender = require '../file-appender'
moment = require 'moment'

class BookingHeaderAppender extends FileAppender
	doAppend: (itineraryResult, callback) ->
		if !itineraryResult.Booking.Header?
			return callback null
		updateDate = @dataDate
		appendCSV = @appendCSV
		filePath = @filePath
		fileName = @fileName
		record = []
		
		header = itineraryResult.Booking.Header[0].BookingHeader[0]
		record.push header.booking_id[0]
		record.push header.client_profile_id[0]
		record.push header.booking_number[0]
		record.push header.record_locator[0]
		record.push header.booking_source_rcd[0]
		record.push moment(header.create_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
		record.push header.create_by[0]
		record.push header.number_of_adults[0]
		record.push header.number_of_children[0]
		record.push header.number_of_infants[0]
		record.push moment(header.update_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
		record.push header.update_by[0]
		record.push header.currency_rcd[0]
		record.push header.language_rcd[0]
		record.push header.agency_code[0]
		record.push header.contact_name[0]
		record.push header.contact_email[0]
		record.push header.contact_email_cc[0]
		record.push header.mobile_email[0]
		record.push header.phone_mobile[0]
		record.push header.phone_mobile_cc[0]
		record.push header.phone_home[0]
		record.push header.phone_business[0]
		record.push header.received_from[0]
		record.push header.phone_fax[0]
		record.push header.phone_search[0]
		record.push header.comment[0]
		record.push header.notify_by_rcd[0]
		record.push header.notify_by_email_flag[0]
		record.push header.notify_by_sms_flag[0]
		record.push header.group_name[0]
		record.push header.group_booking_flag[0]
		record.push header.package_booking_flag[0]
		record.push header.lastname[0]
		record.push header.firstname[0]
		record.push header.middlename[0]
		record.push header.address_line1[0]
		record.push header.address_line2[0]
		record.push header.street[0]
		record.push header.state[0]
		record.push header.district[0]
		record.push header.province[0]
		record.push header.city[0]
		record.push header.zip_code[0]
		record.push header.po_box[0]
		record.push header.title_rcd[0]
		record.push header.country_rcd[0]
		record.push header.no_vat_flag[0]
		record.push header.country_name[0]
		record.push header.invoice_receiver[0]
		record.push header.booking_tax_id[0]
		record.push header.purchase_order[0]
		record.push header.project_number[0]
		record.push header.cost_center[0]
		record.push moment(header.auto_cancel_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
		record.push header.external_payment_reference[0]
		record.push header.ip_address[0]
		record.push header.approval_flag[0]
		record.push header.newsletter_flag[0]
		record.push header.business_flag[0]
		record.push header.ticket_agency_address[0]
		record.push header.client_number[0]
		record.push header.create_name[0]
		record.push header.update_name[0]
		record.push moment(header.utc_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
		record.push header.ticket_total[0]
		record.push header.fee_total[0]
		record.push header.ticket_payment_total[0]
		record.push header.fee_payment_total[0]
		# record.push updateDate
		appendCSV filePath, fileName, record, (err) ->
				if err?
					return callback err
		callback null

	module.exports = BookingHeaderAppender