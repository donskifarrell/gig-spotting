class Gig
	include MongoMapper::Document

	key :artist, String
	key :lat, String
	key :lng, String
	key :city, String
	key :dateFrom, String
	key :dateTo, String

	def as_json(options={})
	{
		:artist       	=> self.artist,
		:markerLocation	=> [self.lat, self.lng] 
	}
	end

end
