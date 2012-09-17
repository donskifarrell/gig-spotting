require 'logger'

class HomeController < ApplicationController
	#$log = Logger.new("/home/donski/dev/gig-spotting/log.txt")
	$log = Rails.logger
	
	# GET /index
	# GET /index.json
	def index
		$log.info "HomeController -> Index"
		@distances = {'1 Mile' => 1, '10 Miles' => 2, 'The World' => 3}
	end
end
