# The purpose of this class is to return a list of restaurants that are
# closest to the location specified
class Places < ActiveRecord::Base
  include PlacesHelper

  # This function is used to find the restaurant results by
  # querying google
  def self.findPlaces lat, long, radius, type = ""

    # The following case statement will select a random API key
    # because we are only allowed to make 1000 queries per key
    # a day, by randomly selecting from several keys we are
    # able to make several thousand queries
    a = rand(6)
    case a
      when 0
        api_key = 'AIzaSyARCJzx62dNJ2eYWbV8bu0c6sU8LSF73P0'
      when 1
        api_key = 'AIzaSyDcKmfg6IyjBMtSIREJEeYX1vRX1G_gUEc'
      when 2
        api_key = 'AIzaSyDtdYEXhy0vOMwoPEASOjp10R6DuUKjBv0'
      when 3
        api_key = 'AIzaSyCzGNpS3LtGLe3NVSfSm3IfqUi97DL_Rr4'
      when 4
        api_key = 'AIzaSyBdfbDfA6R0H0e3gDPXHNIW4cNJJAEjSss'
      when 5
        api_key = 'AIzaSyBt5zF6zrR4CWt8fL18BtxQ3yuJXF8A4yU'
    end

    # Call build url to create the URL that will attain our
    # restaurant results
    url = PlacesHelper.build_url(lat, long, radius, type, api_key)

    # Get the json representation of the results from google
    # this json will contain up to 20 restaurants
    response = PlacesHelper.query_url(url)
  end

end