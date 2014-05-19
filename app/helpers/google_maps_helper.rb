module GoogleMapsHelper

  # Returns the full title on a per-page basis.
  # we assume that this is valid
  def self.get_routes(googleMapsJson)
    #check if it is a json

    #extract if it is relevant
    routes = googleMapsJson['routes'][0]['legs'][0]['steps']

    #return. Must note what happens on failure.
    return routes

  end

  def self.get_status(json)
    Google_Maps.get_status(json)
  end

  def self.get_route_from_google_maps_json(routeOfTripJson)
  #should check but it is supposed to be already parsed coming in
#check to see if this is a google maps valid json
#1) Check if the string is formated ok as a JSON
#2) Check if the status is ok

#3) Extract the steps/legs portion of the json
    stepsOfRoute = get_routes(routeOfTripJson)

#extract the boxes, if possible
    arrayOfCoordinates = Array.new()

    stepsOfRoute.each do |item|
      #Rails.logger.info item['start_location']
      starting_coordinate = item['start_location']
      lat = starting_coordinate['lat']
      lng = starting_coordinate['lng']

      coordinates = Array.new()
      coordinates.push(lat)
      coordinates.push(lng)

      arrayOfCoordinates.push(coordinates)

    end
    return arrayOfCoordinates
  end

end
