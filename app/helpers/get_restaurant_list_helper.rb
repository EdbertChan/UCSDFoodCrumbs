module GetRestaurantListHelper

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

def self.get_points_for_routeboxer(mapsfromGoogleRoutes)
  if(GoogleMap.get_geostop(mapsfromGoogleRoutes) != nil)
    return GoogleMap.get_geostop(mapsfromGoogleRoutes)
  end
  return GoogleMap.get_direction(mapsfromGoogleRoutes)
end

  def self.get_direction(mapsfromGoogleRoutes)
    return GoogleMap.get_direction(mapsfromGoogleRoutes)
  end
end
