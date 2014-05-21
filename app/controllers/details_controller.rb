require 'google_places'

class DetailsController < ApplicationController
  def index

    @detailsJSON = getDetails(params[:reference])
    
=begin
        #@query = Places.find( 33.742006, -117.843843 )
        @client = GooglePlaces::Client.new('AIzaSyBdfbDfA6R0H0e3gDPXHNIW4cNJJAEjSss')
        @query = @client.spots_by_query('Horchatas near UCSD', :radius => 100)
        @query.each do |x|
           @details = Details.getDetails(x.reference)
           break
        end
        return @details
=end

  end
end
