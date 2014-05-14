module RouteBoxerHelper

  # Returns the full title on a per-page basis.
  def self.get_route_boxes(arrayOfRouteLocations, radius)
    #check to make sure array of Boxes is ok

    #check to make sure radius is numeric. If it isn't valid, we input our own defualt
    #screw that let google handle it
   # valid_radius = 10
    #if(numeric?(radius))
     # valid_radius = radius
    #end

    #we should probably let the user know? Nah, let google handle it
    #make the php function call and return it


    arrayOfBoxesJSON = `php app/assets/php/src/getBoxes.php #{arrayOfRouteLocations} #{radius}`
    return arrayOfBoxesJSON

    end

    def self.numeric?(object)
      true if Float(object) rescue false
    end

  def self.get_route_from_google_maps_json(routeOfTripJson)
    #check to see if this is a google maps valid json
    #1) Check if the string is formated ok as a JSON
    #2) Check if the status is ok

    #extract the boxes, if possible
    arrayOfCoordinates = Array.new()

    routeOfTripJson.each do |item|
      #Rails.logger.info item['start_location']
      starting_coordinate = item['start_location']
      lat = starting_coordinate['lat']
      lng = starting_coordinate['lng']

      coordinates = Array.new()
      coordinates.push(lat)
       coordinates.push(lng)

      arrayOfCoordinates.push(coordinates)
    end


    #return an array of coordinate points
return arrayOfCoordinates
  end

end