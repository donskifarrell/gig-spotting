class Search
  include MongoMapper::Document

  key :artist, String
  key :location, String
  key :dateFrom, String
  key :dateTo, String

end
