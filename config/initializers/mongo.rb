Rails.logger.info('######################## TESTSSTS!')
Rails.logger.info('#############')
Rails.logger.info(Rails.env.production?)

if Rails.env.production?
	Rails.logger.info('########################  In production!')
	Rails.logger.info(Rails.env.production?)
	Rails.logger.info(Rails.env.production)
	MongoMapper.connection = Mongo::Connection.from_uri(ENV['MONGOLAB_URI'])
	MongoMapper.database = ENV['MONGOLAB_DB']
else
	Rails.logger.info('########################  Not in production mode!')
	MongoMapper.connection = Mongo::Connection.new('localhost', 27020)
	MongoMapper.database = "#myapp-#{Rails.env}"
end
