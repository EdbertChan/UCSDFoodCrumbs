#include GetRestaurantListHelper
require 'net/http'
require 'rubygems'
require 'json'
require 'active_support'
class GetRestaurantListsController < ApplicationController
  include GetRestaurantListHelper
  include JsonHelper
  include GoogleMapsHelper

#helper:all
#need the filter
  helper_method :all
#Check if the parameters exist before we do ANYTHING
#before_filter :ensure_params_exist

  # GET /get_restaurant_lists
  # GET /get_restaurant_lists.json
=begin
  #1. Get the JSON from Maps
   mapsJSON = GetRestaurantList.get_google_maps(params)
    #check if it is valid
    jsonStr = {:routes => mapsJSON}

    #if(GoogleMapsHelper.isValid(mapsJSON))
      #render json: jsonStr
     # return
    #end

    routeOfTrip = GoogleMapsHelper.get_routes(mapsJSON)
    #2. Push the stuff to routeBoxer. Ask Dheraj if he wants just the two points
    # or if he just wants the google json (We have no idea)
    #routeBoxes = GetRestaurantList.get_route_boxes(routeOfTrip)


#this is now a jsonarry. how do we itterate though a json Array?
    #3. Push each and every box to GooglePlaces
   # hashOfPlacesJsonResponse = {}
    #for i in 0...boxesArray.size
     #  placeResponse = GetRestaurantList.get_restaurant_along_route(i)
     # hashOfPlacesJsonResponse = GetRestaurantHelper.get_restaurant_json_hasher(hashOfPlacesJsonResponse, placeResponse)
  #  end

   render json: routeOfTrip
=end
  def index

      #1. Get the JSON from Maps
    mapsJSON = GetRestaurantList.get_google_maps(params)

      #check if it is valid
     jsonStr = {:routes => mapsJSON}


      #if(GoogleMapsHelper.isValid(mapsJSON))
      #render json: jsonStr
      # return
      #end

      routeOfTrip = GoogleMapsHelper.get_routes(mapsJSON)
      #jsonStr = {:routes => routeOfTrip}

    #now we have a json array. we want to extract all the start_locations from them
    #extract the points along the route
    arrayOfRouteLocations = RouteBoxerHelper.get_route_from_google_maps_json(routeOfTrip)

      #2. Push the stuff to routeBoxer.
      # arg1 should be an array of coordinate. arg2 should be the radius
    #to run php code, we take the stdout of php and it gets assigned to a variable. This is just the location of
    #the script
    #returns an array of arrays
    arrayOfBoxCoordinates = RouteBoxerHelper.get_route_boxes(arrayOfRouteLocations, 5)


     #Yank out all the boxes, if possible.
     #If something goes wrong, just return and do not go to 3
     #arrayOfBoxes

      #3. Push each and every box to GooglePlaces
       hashOfPlacesJsonResponse = {}
      for i in 0...boxesArray.size
        placeResponse = GetRestaurantList.get_restaurant_along_route(arrayOfBoxCoordinates[i])
       hashOfPlacesJsonResponse = GetRestaurantHelper.get_restaurant_json_hasher(hashOfPlacesJsonResponse, placeResponse)
      end

      #Hash together the responses
     places = {:places => ActiveSupport::JSON.decode(hashOfPlacesJsonResponse)}

     #merge the results with the json string and return
     #render the json and return
     jsonStr = jsonStr.merge(places)
    render json: jsonStr
#puts(routeBoxerJSON)
  end

  def testMethod
    #this method is called by our helper to show a proof of concept
    puts("GetRestaurantListsController.testMethod called!")
  end
  # GET /get_restaurant_lists/1
  # GET /get_restaurant_lists/1.json
  def show
    @get_restaurant_list = GetRestaurantList.find(params[:id])

    render json: @get_restaurant_list
  end

  # POST /get_restaurant_lists
  # POST /get_restaurant_lists.json
  def create
    @get_restaurant_list = GetRestaurantList.new(params[:get_restaurant_list])

    if @get_restaurant_list.save
      render json: @get_restaurant_list, status: :created, location: @get_restaurant_list
    else
      render json: @get_restaurant_list.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /get_restaurant_lists/1
  # PATCH/PUT /get_restaurant_lists/1.json
  def update
    @get_restaurant_list = GetRestaurantList.find(params[:id])

    if @get_restaurant_list.update(params[:get_restaurant_list])
      head :no_content
    else
      render json: @get_restaurant_list.errors, status: :unprocessable_entity
    end
  end

  # DELETE /get_restaurant_lists/1
  # DELETE /get_restaurant_lists/1.json
  def destroy
    @get_restaurant_list = GetRestaurantList.find(params[:id])
    @get_restaurant_list.destroy

    head :no_content
  end

 end
