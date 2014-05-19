require 'google_places'

class PlacesController < ApplicationController
  include PlacesHelper

  def index
 
    #first register client
    #@client = GooglePlaces::Client.new('AIzaSyBdfbDfA6R0H0e3gDPXHNIW4cNJJAEjSss')

   #@spotList = @client.spots('33.12312', 151.1957362, :types => ['restaurant','food'])

    # search by a radius (in meters)
    # @radiusList = @client.spots( -33.8670522, 151.1957362, :radius => 100)

    #lat,long = Places.passCoordinates( 33.742006, -117.843843 )
    #@query = render :json => @client.spots( lat, long, :radius => 1000)
    
    @query = render :json => Places.find( 33.742006, -117.843843 )

    # search based on query
    #@query = @client.spots_by_query('Horchatas near UCSD', :radius => 100)
    #@query = @client.spots_by_query('Quick bite near tustin, CA', :types => 'food', :radius => 1000)
  end
end
