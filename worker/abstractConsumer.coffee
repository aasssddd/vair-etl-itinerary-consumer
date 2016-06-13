# abstractConsumer.coffee
Consumer = require 'sqs-consumer'
AWS = require 'aws-sdk'
{EventEmitter} = require 'events'

class AbstractConsumer extends EventEmitter

	events: 
		start: "start"
		error: "error"
		onData: "data"
		proceed: "proceed"

	consumer = null
	constructor: (awsCrediential, apiVersion) ->
		AWS.config.update {
			accessKeyId: awsCrediential.accessKeyId
			secretAccessKey: awsCrediential.secretAccessKey
			region: awsCrediential.region
		}
		AWS.config.apiVersion = apiVersion ? "2012-11-05"
		console.log "SQS Service Initialized"

	start: (queueUrl) ->
		@emit @events.start
		onData = @onData
		onProceed = @onProceed
		@consumer = Consumer.create {
			sqs: new AWS.SQS
			queueUrl: queueUrl
			handleMessage: (message, done) ->
				onData message, done
		}
		@consumer.on 'error', (err) ->
			@emit events.error, err
		@consumer.on 'message_processed', (message) -> 
			onProceed message
		@consumer.start()

	onProceed: (message) ->

	stop: () ->
		if consumer?
			consumer.stop()
		@emit events.stop

	onData: (message, done) ->

module.exports = AbstractConsumer