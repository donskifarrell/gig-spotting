class Search
  include MongoMapper::Document

  key :artist, String
  key :location, String
  key :radius, String

end
