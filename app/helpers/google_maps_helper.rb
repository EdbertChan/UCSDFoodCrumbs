module GoogleMapsHelper

  # Returns the full title on a per-page basis.
  def self.get_routes(googleMapsJson)
    #check if it is a json

    #extract if it is relevant
    routes = googleMapsJson['routes'][0]['legs'][0]['steps']

    #return. Must note what happens on failure.
    return routes

  end



end
