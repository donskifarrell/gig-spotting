require 'logger'
require 'songkick'

class SearchGigsController < ApplicationController
	$log = Logger.new("/home/donski/dev/gig-spotting/log.txt")
	$songkick = Songkick.new("zUTcTZnxJaPNYxrd")

	# GET /search
	# GET /search.json
	def search
		$log.info "SearchGigsController -> Index"
		$gigs = []

		if params.include? :artist 
			@search = Search.new(
				:artist => params[:artist],
				:location => params[:location],
				:date => params[:date]
			).save

			$log.info " - Searching for artist: " + params[:artist]
			searchResults = $songkick.search_artists(params[:artist])

			artists = getArtists(searchResults)
			artists.each do |artist|
				artistName = artist['displayName']
				$log.info ' -- Artist Name: ' + artistName.inspect
				artistEvents = getArtistEvents(artist)
				next if artistEvents.nil?

				$gigs << getEventDetails(artistName, artistEvents)
			end

			$gigs = $gigs.flatten(1)
			$log.info ' - Gigs: ' + $gigs.inspect
		end

		respond_to do |format|
			format.json  {
				render :json => $gigs.to_json
			}
		end 
	end

	def getArtistEvents(artist)
		# It appears that all event links for an artist produce the same calendar,
		# so we only really need the first one.
		eventLink = getArtistEventLinks(artist)[0]
		if eventLink.nil?		
			$log.info ' --- Event mbid NIL'
			$log.info ' --- Artist Detail: ' + artist.inspect
			return
		end
		$log.info ' --- Event mbid: ' + eventLink

		eventResults = $songkick.artist_calendar('mbid:' + eventLink)
		return getEvents(eventResults)
	end

	def getArtistEventLinks(artist)
		mbids = Array.new
		artist['identifier'].each do |link|
			mbids << link['mbid']
		end
		return mbids
	end

	def getEventDetails(artistName, events)
		eventDetails = []
		events.each do |event|
			eventDetails << 
				{
					'artist' => artistName,
					'gigName' => event['displayName'],
					'location' => [ 
						event['location']['lat'].to_s(), 
						event['location']['lng'].to_s() 
					],
					'date' => event['start']['date'],
					'matchRating' => 'matchRating',
					'details' => 'Gig Details',
					'suportingActs' => getSupportingActs(artistName, event['performance'])
				}
		end
		$log.info ' ---- Event Details: ' + eventDetails.to_json
		return eventDetails
	end

	def getSupportingActs(artistName, acts)
		supportingActs = []
		acts.each do |act|	
			if act['displayName'] != artistName
				supportingActs << {
					'name' => act['displayName']
				}
			end
		end
		return supportingActs
	end	

	def getArtists(resultSet)
		artistSet = resultSet['resultsPage']['results']['artist']		
		#$log.info ' --- Artists: ' + artistSet.inspect
		return artistSet
	end	

	def getEvents(resultSet)
		eventsSet = resultSet['resultsPage']['results']['event']		
		#$log.info ' --- Events: ' + eventsSet.inspect
		return eventsSet
	end
end
