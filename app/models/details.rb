require 'google_places'
require 'net/http'
require 'json'
require 'active_support'

class Details < ActiveRecord::Base
include JsonHelper


    def self.getDetails(ref)
      url =  "https://maps.googleapis.com/maps/api/place/details/json?reference=#{ref}" + "&sensor=false" + "&key=AIzaSyBdfbDfA6R0H0e3gDPXHNIW4cNJJAEjSss"
      response = JsonHelper.query_json(url)
      @details = response
    end
end
