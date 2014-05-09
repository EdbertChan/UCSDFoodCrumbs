module GetRestaurantListHelper

  # Returns the full title on a per-page basis.
def @self.get_google_maps(params)
  return GoogleMaps.getRoutes(params)
end

# Returns the route boxes response
  def @self.get_route_boxes(routeBoxes)
    return RouteBoxes.getBoxes(routeBoxes)
  end

  #Returns the restaurants response
  def @self.get_restaurant_along_route(setOfPoints)
    return RestaurantsAlongRoute.getRestaurant(setOfPoints)
  end


end
