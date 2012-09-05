require 'logger'

class HomeController < ApplicationController
	$log = Logger.new("/home/donski/dev/gig-spotting/log.txt")

	# GET /index
	# GET /index.json
	def index
		$log.info "HomeController -> Index"
	end
end
