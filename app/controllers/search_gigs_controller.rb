require 'logger'
require 'songkick'
require 'pp'

class SearchGigsController < ApplicationController
	$log = Logger.new("/home/donski/dev/gig-spotting/log.txt")
	$songkick = Songkick.new("zUTcTZnxJaPNYxrd")

	# GET /search
	# GET /search.json
	def search
		$log.info "SearchGigsController -> Index"

		if params.include? :artist 
			@search = Search.new(
				:artist => params[:artist],
				:location => params[:location],
				:date => params[:date]
			).save
			$log.info "Searching for artist: " + params[:artist]
			results = $songkick.search_artists(params[:artist])

			artistList = getArtistList(results)
			#$log.info 'Artists List: ' + artistList.inspect

			# Assume index 0 is matching artist for now
			displayName = getAttributeValue(artistList[0], 'displayName')
			$log.info 'Display Name: ' + displayName.inspect

			links = getAttributeValue(artistList[0], 'identifier')
			mbid = getAttributeValue(links[0], 'mbid')
			$log.info 'mbid: ' + mbid.inspect



			events = $songkick.artist_calendar('mbid:'+mbid)
			#$log.info 'Events: ' + events.inspect

			eventList = getEventList(events)
			$log.info 'Event List: ' + eventList.inspect

			location = getAttributeValue(eventList[0], 'location')
			lat = location['lat']
			lng = location['lng']

			@gig = Gig.new(
				:artist => displayName,
				:lat => lat,
				:lng => lng
			)
			@gig.save

			$log.info 'Gig info: ' + @gig.to_json
		else
			@gig = Gig.new(
				:artist => "Dummy"
			)
			@gig.save
		end

		respond_to do |format|
			format.json  {
				render :json => @gig.to_json
			}
		end 
	end

	def getArtistList(resultSet)
		resultSet['resultsPage']['results']['artist']
	end	

	def getEventList(resultSet)
		resultSet['resultsPage']['results']['event']
	end	

	def getAttributeValue(hashObject, attributeName)
		hashObject[attributeName]
	end	
end
