module GetRestaurantListHelper
include GoogleMapsHelper
  # Returns the full title on a per-page basis.
def self.get_google_maps(params)
  return GoogleMap.get_directions_json(params)
end

# Returns the route boxes response

  def self.get_route_points(mapsfromGoogleRoutes)
    return GoogleMap.get_route_points(mapsfromGoogleRoutes)
  end

  def self.get_geostop(mapsfromGoogleRoutes)
    return GoogleMap.get_geostop(mapsfromGoogleRoutes)
  end

def self.get_valid_hash(mapsfromGoogleRoutes)
  if(GoogleMapsHelper.get_geostop(mapsfromGoogleRoutes) != nil)
    return GoogleMapsHelper.get_geostop(mapsfromGoogleRoutes)
  end
  return GoogleMapsHelper.get_direction(mapsfromGoogleRoutes)
end

  def self.get_direction(mapsfromGoogleRoutes)
    return GoogleMap.get_direction(mapsfromGoogleRoutes)
  end
end
