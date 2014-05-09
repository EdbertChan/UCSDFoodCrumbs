#include GetRestaurantListHelper
require 'net/http'
require 'rubygems'
require 'json'
require 'active_support'
class GetRestaurantListsController < ApplicationController
  include GetRestaurantListHelper
  include JsonHelper

#helper:all
#need the filter
  helper_method :all
#Check if the parameters exist before we do ANYTHING
#before_filter :ensure_params_exist

  # GET /get_restaurant_lists
  # GET /get_restaurant_lists.json

  def index
    #1. Get the JSON from Maps
    mapsJSON = GetRestaurantList.get_route_directions_json(params)
    #check if it is valid
    jsonStr = {:routes => ActiveSupport::JSON.decode(mapsJSON)}
    if(GoogleMapsHelper.isValid(mapsJSON))
      render json: jsonStr
      return
    end
   #2. Push the stuff to routeBoxer
    routeBoxes = GetRestaurantList.get_route_boxes(routeOfTrip)

    #check to see if the return is valid?

    #3. Push each and every box to GooglePlaces
    hashOfPlacesJsonResponse = {}
    for i in 0...routeBoxes.size
      placeResponse = GetRestaurantList.get_restaurant_along_route()
      #listOfPlaces.push(placeResponse)
      hashOfPlacesJsonResponse = GetRestaurantHelper.get_restaurant_json_hasher(hashOfPlacesJsonResponse, placeResponse)
    end
    #Hash together the responses
    places = {:places => ActiveSupport::JSON.decode(hashOfPlacesJsonResponse)}

    #render the json and return
    jsonStr = jsonStr.merge(places)
    render json: jsonStr
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
protected
   
private
  def ensure_params_exist
return unless params[:origin].blank?
render :json=>{:success=>false, :message=>"missing user_login parameter"}, :status=>0
end
 end
