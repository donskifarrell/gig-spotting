Rails.logger.info('######################## TESTSSTS!')
Rails.logger.info('#############')
Rails.logger.info(Rails.env.production?)
puts '######################## TESTSSTS!'
puts '#############'
puts Rails.env.production?

if Rails.env.production?
	puts '########################  In production!'
	puts Rails.env.production?
	puts Rails.env.production
	MongoMapper.connection = Mongo::Connection.from_uri(ENV['MONGOLAB_URI'])
	MongoMapper.database = ENV['MONGOLAB_DB']
else
	puts '########################  Not in production mode!'
	MongoMapper.connection = Mongo::Connection.new('localhost', 27020)
	MongoMapper.database = "#myapp-#{Rails.env}"
end
