require 'google_places'

include PlacesHelper
class Places < ActiveRecord::Base
  def self.find( long, lat )
    @client = GooglePlaces::Client.new('AIzaSyBdfbDfA6R0H0e3gDPXHNIW4cNJJAEjSss')
    return @client.spots(long, lat)
  end
end
