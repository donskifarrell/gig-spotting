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
		:artist       => self.artist,
		:lat         => self.lat,
		:lng        => self.lng
	}
	end

end
