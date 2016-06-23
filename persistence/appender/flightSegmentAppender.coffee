# flightSegmentAppender.coffee
FileAppender = require '../file-appender'
moment = require 'moment'

class FlightSegmentAppender extends FileAppender
	doAppend: (itineraryResult, callback) ->
		if !itineraryResult.Booking.Itinerary?
			return callback null
		updateDate = @dataDate
		appendCSV = @appendCSV
		filePath = @filePath
		fileName = @fileName
		flightSegments = itineraryResult.Booking.Itinerary[0].FlightSegment
		flightSegments.forEach (item) ->
			record = []
			record.push item.booking_segment_id[0]
			record.push item.flight_id[0]
			record.push item.airline_rcd[0]
			record.push item.flight_number[0]
			record.push moment(item.departure_date[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push moment(item.arrival_date[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.booking_class_rcd[0]
			record.push item.boarding_class_rcd[0]
			record.push item.create_by[0]
			record.push moment(item.create_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.update_by[0]
			record.push moment(item.update_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.departure_time[0]
			record.push item.arrival_time[0]
			record.push item.journey_time[0]
			record.push item.segment_status_rcd[0]
			record.push item.segment_change_status_rcd[0]
			record.push item.booking_id[0]
			record.push item.number_of_units[0]
			record.push item.origin_rcd[0]
			record.push item.destination_rcd[0]
			record.push item.od_origin_rcd[0]
			record.push item.od_destination_rcd[0]
			record.push item.flight_connection_id[0]
			record.push item.temp_seatmap_flag[0]
			record.push item.seatmap_flag[0]
			record.push item.status_name[0]
			record.push item.class_name[0]
			record.push item.airline_name[0]
			record.push item.origin_name[0]
			record.push item.destination_name[0]
			record.push item.transit_points_name[0]
			record.push item.origin_terminal[0]
			record.push item.destination_terminal[0]
			record.push item.origin_phone[0]
			record.push item.destination_phone[0]
			record.push item.planned_arrival_time[0]
			record.push moment(item.flight_flown_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.transit_points[0]
			record.push item.day_change_value[0]
			record.push item.domestic_flag[0]
			record.push item.allow_web_checkin_flag[0]
			record.push item.operating_airline_rcd[0]
			record.push item.operating_flight_number[0]
			record.push item.flight_status_name[0]
			record.push item.flight_information_1[0]
			record.push item.flight_information_2[0]
			record.push item.flight_information_3[0]
			record.push item.flight_check_in_status_rcd[0]
			record.push item.number_of_stops[0]
			record.push item.flight_flown_name[0]
			record.push item.create_name[0]
			record.push item.update_name[0]
			record.push moment(item.check_in_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push moment(item.utc_departure_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push moment(item.utc_arrival_date_time[0], "YYYYMMDD HH:mm:ss").format "YYYY/MM/DD HH:mm:ss"
			record.push item.close_web_sales_flag[0]
			# record.push updateDate
			appendCSV filePath, fileName, record, (err) ->
				if err?
					return callback err
		callback null

module.exports = FlightSegmentAppender