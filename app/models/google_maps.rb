include GoogleMapsHelper
require 'active_support'

class GoogleMaps < ActiveRecord::Base
  #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  # All methods called in this module is located in the google_maps_helper
  #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   
  #get_directions_json call which shall return json
  def self.get_directions_json(params)
 
    # get our uri key from helper method get_uri
    url_key = get_url(params)
    # get our route JSON
    jsonRoute = get_json(url_key)
    
    # NEW FUNCTIONALITY BEGIN
    directions = {:routes => JSON.parse(jsonRoute)}
    #directions[:routes => jsonRoute]
    # HASH PROBLEM
    if(get_json_status(JSON.parse(jsonRoute) ) == ENV["MAPS_VALID_CODE"])

      # get keyCode determined by time/distance param
      keyCode = time_dist_check(params)
      
      # keyCode matching time param
      if(keyCode == 1)
        time = params[:time]
        time = time.to_f

        #HASH PROBLEM
        geoStop = get_json_time(jsonRoute,time)

        directions[:geoStop] = JSON.parse(geoStop)
        
      # keyCode matching distance param
      elsif(keyCode == 2)
        distance = params[:distance]
        distance = distance.to_f
        
        #HASH PROBLEM
        geoStop = get_json_distance(jsonRoute,distance)
        directions[:geoStop] = JSON.parse(geoStop)

      end 
 
    end


    return directions

    # NEW FUNCTIONALITY END
  end

  # this call gets you the status code 
  def self.get_json_status(jsonRoute)

    status = get_status(jsonRoute)

  end
    
  # gets our points
  def self.get_route_points(jsonRoute)

    points = get_points(jsonRoute)

  end


  def self.get_direction(jsonHash)
    return GoogleMapsHelper.get_direction(jsonHash)
  end

  def self.get_geostop(jsonHash)
    return GoogleMapsHelper.get_geostop(jsonHash)
  end
end
