require 'logger'

class HomeController < ApplicationController
	$log = Logger.new("/home/donski/dev/gig-spotting/log.txt")
	$songkick = "";

	# GET /index
	# GET /index.json
	def index
		$log.info "Index"

		if params.include? :artist 
			@search = Search.new(
				:artist => params[:artist],
				:location => params[:location],
				:date => params[:date]
			).save

			artists = $songkick.artist(params[:artist])
			if artists.success?			    
				$log.info "Success..."
				$log.info artists
		    else
				$log.info "FAILED..."
				$log.info artists
		    end

			@gig = Gig.where(:artist => params[:artist]).first
			@gigs = Gig.all
		end

		respond_to do |format|
			format.html
			format.js  {render :content_type => 'text/javascript'}
		end 
	end
end
