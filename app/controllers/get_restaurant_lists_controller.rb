#include GetRestaurantListHelper
require 'net/http'
require 'rubygems'
require 'json'
require 'active_support'
require 'yaml'


class GetRestaurantListsController < ApplicationController
  include GetRestaurantListHelper
  include JsonHelper
  include GoogleMapsHelper

#helper:all
#need the filter
  helper_method :all
#Check if the parameters exist before we do ANYTHING

# GET /get_restaurant_lists
# GET /get_restaurant_lists.json

  def index

    #1. Get the JSON Hash

      mapsfromGoogleRoutes= GetRestaurantList.get_google_maps(params)

      jsonStr = GetRestaurantList.generate_json_maps(mapsfromGoogleRoutes)

    if(GetRestaurantList.get_status_of_map(mapsfromGoogleRoutes) != ENV["MAPS_VALID_CODE"])
      render json:jsonStr
      return
    end

    arrayOfRouteLocations = GetRestaurantList.get_array_points_for_boxer(mapsfromGoogleRoutes)
    #now we have a json array. we want to extract all the start_locations from them
    #extract the points along the route


    #2. Push the stuff to routeBoxer.
    # arg1 should be an array of coordinate. arg2 should be the radius

      #convert the miles into kilometers

defaultParameter = 4
    if(params.has_key? (:radius))
      defaultParameter = params[:radius].to_f/1.6
    end
    jsonArrayofUserDefinedRouteBoxes = RouteBoxerHelper.get_route_boxes(arrayOfRouteLocations, defaultParameter)

    #boxer has these as a json. We're going to convert these to an array of array of array of floats
    arrayOfBoxCoordinatesUser = RouteBoxerHelper.convert_route_boxes_json_to_array(jsonArrayofUserDefinedRouteBoxes)
   # begin algorithm part
 
    #get it as google max
    jsonArrayofGoogleMaxRouteBoxes = RouteBoxerHelper.get_route_boxes(arrayOfRouteLocations,20)

    #boxer has these as a json. We're going to convert these to an array of array of array of floats
    arrayOfBoxCoordinatesGoogleMax = RouteBoxerHelper.convert_route_boxes_json_to_array(jsonArrayofGoogleMaxRouteBoxes)



#need to parse
   #p arrayOfBoxCoordinatesUser;
    routeLength = GooglePlacesHelper.getRouteLength(mapsfromGoogleRoutes)

places = PlacesFinder.getPlaces(arrayOfBoxCoordinatesGoogleMax,arrayOfBoxCoordinatesUser,params, routeLength)


    jsonPlaces = {:places => ActiveSupport::JSON.decode(places)}
    jsonStr = jsonStr.merge(jsonPlaces)

render json:jsonStr

  end



end
