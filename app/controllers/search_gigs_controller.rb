require 'logger'
require 'songkick'
require 'echonest'

class SearchGigsController < ApplicationController
	$log = Logger.new("/home/donski/dev/gig-spotting/log.txt")
	$songkick = Songkick.new("zUTcTZnxJaPNYxrd")
	$echo = Echonest::Api.new("LTTNLEA1WOX7IP2HX")
	$gigsFound = []

	# GET /search
	# GET /search.json
	def search
		$log.info "SearchGigsController -> Index"
		gigs = []
		artistNames = []

		if params.include? :artist 
			@search = Search.new(
				:artist => params[:artist],
				:location => params[:location],
				:date => params[:date]
			).save

			artistNames.push params[:artist]
			artistNames.push *getSimilarArtists(params[:artist])
			gigs.push *getGigs(artistNames)
			#$log.info ' - Gigs Found: ' + gigs.inspect
		end

		respond_to do |format|
			format.json  {
				render :json => gigs.to_json
			}
		end 
	end

	def getSimilarArtists(artistName)
		similarArtists = []
		artist = Echonest::ApiMethods::Artist.new($echo)
		artist.artist_name = artistName
		artists = artist.send(:similar)
		artists['artists'].each do |artist|
			#$log.info ' - Similar Artist: ' + artist['name']
			similarArtists << artist['name']
		end
		return similarArtists
	end

	def getGigs(artistNames)
		gigs = []
		#$log.info " - Searching for artists: " + $artistNames.inspect
		artistNames.each do |artistName|
			resultSet = $songkick.search_artists(artistName)
			next if resultSet.nil?

			artists = resultSet['resultsPage']['results']['artist']
			artists.each do |artist|
				name = artist['displayName']
				#$log.info ' -- Artist Name: ' + name.inspect
				artistEvents = getArtistEvents(artist)
				next if artistEvents.nil?

				gigs.push *buildEventDetails(name, artistEvents)
			end
		end
		return gigs
	end

	def getArtistEvents(artist)
		# It appears that all event links for an artist produce the same calendar,
		# so we only really need the first one. (But what if there are none!)
		eventLink = getArtistEventLinks(artist)[0]
		if eventLink.nil?		
			$log.info ' --- Event mbid NIL'
			$log.info ' --- Artist Detail: ' + artist.inspect
			return
		end
		#$log.info ' --- Event mbid: ' + eventLink

		eventResults = $songkick.artist_calendar('mbid:' + eventLink)
		return eventResults['resultsPage']['results']['event']
	end

	def getArtistEventLinks(artist)
		mbids = []
		artist['identifier'].each do |link|
			mbids << link['mbid']
		end
		return mbids
	end

	def buildEventDetails(artistName, events)
		eventDetails = []
		events.each do |event|
			next if isGigDuplicate(event)
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
		#$log.info ' ---- Event Details: ' + eventDetails.to_json
		return eventDetails
	end

	def isGigDuplicate(event)
		gig = 
			{
				'gigName' => event['displayName'],
				'location' => [ 
					event['location']['lat'].to_s(), 
					event['location']['lng'].to_s() 
				],
				'date' => event['start']['date']
			}
		if $gigsFound.include?(gig)
			return true
		else
			$gigsFound.push gig
			return false
		end
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
end
