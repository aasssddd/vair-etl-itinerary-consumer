# index.coffee
AbstractConsumer = require './worker/abstractConsumer'
FileAppender = require './persistence/file-appender'
require_tree = require 'require-tree'
appender = require_tree './persistence/appender'
ItineraryService = require './serviceHelper/itineraryService'
Logger = require('vair_log').Logger
async = require 'async'
config = require './config'
MySQL = require './persistence/MySQL'
path = require 'path'
fse = require 'fs-extra'
domain = require 'domain'

db = new MySQL

class ItineraryJobConsumer extends AbstractConsumer
												
	onData: (jsonMessage, done) ->
		# convert string message into json object
		log = Logger.getLogger()
		log.info "#{JSON.stringify jsonMessage.Body}"
		pnrlst = JSON.parse(jsonMessage.Body).pnrlst
		itineraryService = new ItineraryService
		iteratee = (item, key, callback) ->
			log = Logger.getLogger()
			if "#{item}" == "" or not item?
				return setImmediate callback, "No item ", null

			itineraryService.getItinerary item, (err, data) ->
				log.debug "item #{key} triggered"
				if err?
					log.error "wrong response: #{err}"
					return setImmediate callback, err, null
				if data.message is undefined
					log.error "wrong response: #{JSON.stringify data}"
					return setImmediate callback, "wrong response: #{JSON.stringify data}", null
				message = data.message
				if not message?
					log.warn "no message for PNR #{item}"
					return setImmediate callback, null, null
					# return setImmediate callback, "no message for PNR #{item}", null

				fileAppender = new FileAppender

				fileAppender.append message, new appender.bookingHeaderAppender(config.tempFile.path, config.tempFile.fileNames.header), (err) ->
					if err?
						log.error "error: #{err}"
						return setImmediate callback, err, null
					fileAppender.append message, new appender.agencyAppender(config.tempFile.path, config.tempFile.fileNames.agency), (err) ->
						if err?
							log.error "error: #{err}"
							return setImmediate callback, err, null
						fileAppender.append message, new appender.flightSegmentAppender(config.tempFile.path, config.tempFile.fileNames.flightSegment), (err) ->
							if err?
								log.error "error: #{err}"
								return setImmediate callback,null, err
							fileAppender.append message, new appender.passengerAppender(config.tempFile.path, config.tempFile.fileNames.passenger), (err) ->
								if err?
									log.error "error: #{err}"
									return setImmediate callback, err, null
								fileAppender.append message, new appender.remarkAppender(config.tempFile.path, config.tempFile.fileNames.remark), (err) ->
									if err?
										log.error "error: #{err}"
										return setImmediate callback, err, null
									fileAppender.append message, new appender.paymentAppender(config.tempFile.path, config.tempFile.fileNames.payment), (err) ->
										if err?
											log.error "error: #{err}"
											return setImmediate callback, err, null
										fileAppender.append message, new appender.ticketAppender(config.tempFile.path, config.tempFile.fileNames.ticket), (err) ->
											if err?
												log.error "error: #{err}"
												return setImmediate callback, err, null
											fileAppender.append message, new appender.specialServiceAppender(config.tempFile.path, config.tempFile.fileNames.specialService), (err) ->
												if err?
													log.error "error: #{err}"
													return setImmediate callback, err, null
												fileAppender.append message, new appender.taxAppender(config.tempFile.path, config.tempFile.fileNames.tax), (err) ->
													if err?
														log.error "error: #{err}"
														return setImmediate callback, err, null
													fileAppender.append message, new appender.feeAppender(config.tempFile.path, config.tempFile.fileNames.fee), (err) ->
														if err?
															log.error "error: #{err}"
															return setImmediate callback, err, null
														return setImmediate callback, null, null

		if not pnrlst?
			log.error "pnrlist length is zero! data is #{JSON.stringify jsonMessage.Body}"
			db.close()
			process.exit()
		async.forEachOfLimit pnrlst, config.environment.concurrentServiceCallLimit, iteratee, (err) ->
			if err?
				log.error "error: #{err}"
				done err
				process.exit()
			
			async.forEachOf config.tempFile.fileNames, (v, k, cb) ->
				fullpath = "#{config.tempFile.path}/#{v}"
				tableName = v.replace /\.csv/, ""
				db.loadData fullpath, tableName, (err) ->
					if err?
						log.error "table #{tableName} lad fail"
					log.info "table #{tableName} loaded"
					cb err
			, (err) ->
				if err?
					log.error "write to DB error: #{err}"
					db.close()
					process.exit()
				log.info "all table loaded"
				log.info "cleanning house..."
				fse.emptyDir "#{path.resolve config.tempFile.path}", (err) ->
					if err?
						log.error "9999, 花惹發 , #{err}"
						db.close()
						process.exit()
					log.info "OK! ready for process next message"
					done()

log = Logger.getLogger()

d = domain.create()

d.on 'error', (err) ->
	log.error "consumer fail! reason: #{err}"
	db.close()
	process.exit()


d.run =>
	job = new ItineraryJobConsumer {
		accessKeyId: config.aws.accessKeyId
		secretAccessKey: config.aws.secretAccessKey
		region: config.aws.region
	}

	job.on "start", () ->
		log.info "start receiving message"

	job.start config.aws.queueUrl