if Rails.env == 'production'
	MongoMapper.connection = Mongo::Connection.from_uri(ENV['MONGOLAB_URI'])
	MongoMapper.database = ENV['MONGOLAB_DB']
else
	MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
	MongoMapper.database = "#myapp-#{Rails.env}"
end
