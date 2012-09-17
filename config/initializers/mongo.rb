if Rails.env.production?
	puts '########################  In production!'
	puts ENV['MONGOLAB_URI']
	MongoMapper.connection = Mongo::Connection.from_uri(ENV['MONGOLAB_URI'])
	MongoMapper.database = ENV['MONGOLAB_DB']
else
	puts '########################  Not in production mode!'
	MongoMapper.connection = Mongo::Connection.new('localhost', 27020)
	MongoMapper.database = "#myapp-#{Rails.env}"
end
