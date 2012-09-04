require 'logger'
require 'songkick'

class HomeController < ApplicationController
	$log = Logger.new("/home/donski/dev/gig-spotting/log.txt")
	$songkick = Songkick.new("zUTcTZnxJaPNYxrd")

	# GET /index
	# GET /index.json
	def index
		$log.info "HomeController -> Index"

		if params.include? :artist 

			$log.info "include artist..."
			@search = Search.new(
				:artist => params[:artist],
				:location => params[:location],
				:date => params[:date]
			).save
			$log.info "Searching for artist: " + params[:artist]

			#artists = $songkick.search_artists("Muse", :per_page=>'10' ).results
			artists = $songkick.search_artists("Muse")

			artists.each do |result|
			  $log.info "name: " + result.inspect
			end

			if artists.success?			    
				$log.info "Success..."
				$log.info artists
		    else
				$log.info "FAILED..."
				$log.info artists
		    end

			$log.info "Finished search for artist: " + params[:artist]
			@gig = Gig.where(:artist => params[:artist]).first
			@gigs = Gig.all
		end

		respond_to do |format|
			format.html
			format.js  {render :content_type => 'text/javascript'}
		end 

	end
end
