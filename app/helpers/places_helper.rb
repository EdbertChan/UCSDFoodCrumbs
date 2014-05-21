require 'google_places'
require 'json'

module PlacesHelper
@client = GooglePlaces::Client.new('AIzaSyBdfbDfA6R0H0e3gDPXHNIW4cNJJAEjSss') 
    def self.query(lat, long, radius, type)
        if type == ""
            query = @client.spots( lat, long, :radius => radius )
        else
            query = @client.spots( lat, long, :types => type, :radius=> radius )
        end
        return query
    end
end
