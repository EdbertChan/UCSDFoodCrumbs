require 'google_places'

class DetailsController < ApplicationController
  def index
        @query = Places.find( 33.742006, -117.843843 )
        @query.each do |x|
           @details = Details.getDetails(x.reference)
        end
        return @details
  end
end
