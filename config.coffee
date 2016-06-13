# config.coffee
module.exports = 
	aws:
		queueUrl: "https://sqs.us-east-1.amazonaws.com/662107851369/ItineraryJob"
		accessKeyId: "AKIAIQM4MWTKCNE3ALYQ",
		secretAccessKey: "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"
		region: "us-east-1"
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
		host: 'prod1.c536e6lpzfqo.us-west-2.rds.amazonaws.com',
		user: 'vairetl',
		password: 'V@irRDS3TL',
		database: 'pss',
		poolSize: 4

	environment: 
		concurrentServiceCallLimit: 20
		itineraryApiUrl: "http://vairservices-5633393.us-east-1.elb.amazonaws.com/booking/itinerary/"