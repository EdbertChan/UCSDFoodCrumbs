class GetRestaurantList < ActiveRecord::Base

#this class is composed of all the primary methods of the other methods. We will access these other methods
  #with the use of a helper

    def self.get_google_maps(params)
      return GetRestaurantListHelper.get_google_maps(params)
    end

# Returns the route boxes response
    def self.get_route_boxes(routeBoxes)
      return GetRestaurantListHelper.get_route_boxes(routeBoxes)
    end

    #Returns the restaurants response
    def self.get_restaurant_along_route(setOfPoints)
      return GetRestaurantListHelper.get_restaurant_along_route(setOfPoints)
    end

def self.generate_json_maps(mapsfromGoogleRoutes)

  directionsFromGoogle =  GoogleMaps.get_direction(mapsfromGoogleRoutes)

  geostop = GoogleMaps.get_geostop(mapsfromGoogleRoutes)

  #convert map to JSON
  jsonStr = {:routes => directionsFromGoogle, :geostop => geostop}

  return jsonStr
end

  def self.get_status_of_map(mapsfromGoogleRoutes)
    return GetRestaurantListHelper.get_status_of_map(mapsfromGoogleRoutes)
  end

  def self.get_array_points_for_boxer(mapsfromGoogleRoutes)
    return GoogleMaps.get_route_points(GetRestaurantListHelper.get_valid_hash(mapsfromGoogleRoutes))
  end
end
