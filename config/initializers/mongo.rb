puts '########################  Mongo.rb Initialiser'

if Rails.env.production?
	puts '########################  In production!'
	if ENV['MONGOLAB_URI'] != nil
		puts '########################  Setting MongoLab URI!'
		MongoMapper.connection = Mongo::Connection.from_uri(ENV['MONGOLAB_URI'])
		MongoMapper.database = ENV['MONGOLAB_DB']
	end
else
	puts '########################  Not in production mode!'
	MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
	MongoMapper.database = "#myapp-#{Rails.env}"
end