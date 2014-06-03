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


  #Returns the restaurants response
  def self.get_restaurant_along_route(setOfPoints)


        url = "https://maps.googleapis.com/maps/api/directions/json?origin=Pomona,CA&destination=Riverside,CA,92509&sensor=true&key=AIzaSyCS9C8uXjI5_qL5Z31gXj9Zsp5q1QuXpgM"
    #key AIzaSyAAe8uFG4L8f_LYe-7etsNwdXraAUxIcPs

    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)

    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)

    return JSON.parse(response.body)

    #return RestaurantsAlongRoute.getRestaurant(setOfPoints)
  end


end
