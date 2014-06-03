module GetRestaurantListHelper
include GoogleMapsHelper
  # Returns the full title on a per-page basis.
def self.get_google_maps(params)
  return GoogleMaps.get_directions_json(params)
end

# Returns the route boxes response

  def self.get_route_points(mapsfromGoogleRoutes)
    return GoogleMaps.get_route_points(mapsfromGoogleRoutes)
  end

  def self.get_geostop(mapsfromGoogleRoutes)
    return GoogleMaps.get_geostop(mapsfromGoogleRoutes)
  end

def self.get_valid_hash(mapsfromGoogleRoutes)
  if(GoogleMapsHelper.get_geostop(mapsfromGoogleRoutes) != nil)
    return GoogleMapsHelper.get_geostop(mapsfromGoogleRoutes)
  end
  return GoogleMapsHelper.get_direction(mapsfromGoogleRoutes)
end

  def self.get_status_of_map(mapsfromGoogleRoutes)
   return GoogleMaps.get_status(GetRestaurantListHelper.get_valid_hash(mapsfromGoogleRoutes))
  end
end
