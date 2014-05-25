class Places < ActiveRecord::Base
include PlacesHelper
=begin
  def self.getPlaces( lat, long, radius, type )
    foo = PlacesHelper.query( lat, long, radius, type )
  end
=end
    def self.findPlaces lat, long, radius, type = ""
        url = PlacesHelper.build_url(lat, long, radius, type)
        response = PlacesHelper.query_url(url)
    end
   
end
