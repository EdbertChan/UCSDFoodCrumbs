#include GetRestaurantListHelper
require 'net/http'
class GetRestaurantListsController < ApplicationController


#helper GetRestaurantListHelper
#need the filter

#Check if the parameters exist before we do ANYTHING
#before_filter :ensure_params_exist

  # GET /get_restaurant_lists
  # GET /get_restaurant_lists.json

  def index

     #1. Check to see if we can process this anyway?

    #this is code to process the list by using the parameters
    #given by the URL
    #@get_restaurant_lists = GetRestaurantList.find(user_params)
      @get_restaurant_lists = GetRestaurantList.all
   #puts get_route_directions_json(params)

    #2. Check to see if Google request is ok


    #3. Check to see if Yelp request is ok

    #4. Get the list and return it
    
    #nonproduction code. Just used for demoing

#sample SSH call to google maps api
uri = URI('https://maps.googleapis.com/maps/api/directions/json?origin=LaJolla&destination=SanDiego&sensor=false&key=AIzaSyAAe8uFG4L8f_LYe-7etsNwdXraAUxIcPs')
http = Net::HTTP.new(uri.host, uri.port)

http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
request = Net::HTTP::Get.new(uri.request_uri)

response = http.request(request)
    
 #return stuff
 render json: response.body
    
        #render json: @get_restaurant_lists, status: 422
    
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
