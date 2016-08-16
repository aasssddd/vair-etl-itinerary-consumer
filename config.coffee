# config.coffee
module.exports = 
	aws:
		queueUrl: "https://sqs.url"
		accessKeyId: "aws access key id",
		secretAccessKey: "aws secret access key"
		region: "sqs region"
		API_VERSION: "2012-11-05"
		
	tempFile:
		path: "temp" 
		fileNames:
			agency: "itinerary_agency.csv"
			header: "itinerary_bookingheader.csv",
			flightSegment: "itinerary_flightsegment.csv",
			passenger: "itinerary_passengers.csv",
			remark: "itinerary_remark.csv",
			payment: "itinerary_payments.csv",
			ticket: "itinerary_tickets.csv",
			specialService: "itinerary_ssr.csv",
			tax: "itinerary_tax.csv",
			fee: "itinerary_fee.csv"
	
	mysql:
		host: 'https://mysql.url',
		user: 'my sql user',
		password: 'my sql password',
		database: 'database',
		poolSize: 4

	environment: 
		concurrentServiceCallLimit: 20
		itineraryApiUrl: "https://itinerary.api.url"
		# itineraryApiUrl: "http://localhost:8000/booking/itinerary/"