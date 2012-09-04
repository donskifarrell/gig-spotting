class Search
  include MongoMapper::Document

  key :artist, String
  key :location, String
  key :date, String

end
