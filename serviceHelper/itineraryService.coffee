# itineraryService.coffee
Client = require('node-rest-client').Client
config = require '../config'
url = require 'url'

class ItineraryService
	
	constructor: () ->
		@client = new Client
		@urlbase = config.environment.itineraryApiUrl

	getItinerary: (pnr, callback) ->
		args = {
			headers: { 'Cache-Control':'no-cache' }
		}
		console.log "#{@urlbase}/#{pnr}"
		resolvedUrl = url.resolve "#{@urlbase}", "#{pnr}"
		req = @client.get "#{resolvedUrl}", args, (data, resp) ->
			if "#{resp.statusCode}" == "200"
				
				data_json = JSON.stringify(data)
				data_re = data_json.replace /\\\\/g, "\\\\\\\\"
				data = JSON.parse(data_re)
				return callback null, data
			else 
				return callback "#{messages.RESTFUL_RESP_ERROR.code}, #{messages.RESTFUL_RESP_ERROR.message}, #{resp.statusCode}, #{resp.statusMessage}", null
		
		req.on 'error', (err) ->
			return callback err

module.exports = ItineraryService