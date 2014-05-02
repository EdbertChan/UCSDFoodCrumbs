#include GetRestaurantListHelper
require 'net/http'
require 'rubygems'
require 'json'
require 'active_support'
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

responseRoute = http.request(request)


    
    
=begin   
    latPoints = [ "32.84020539999999",
         "32.8404957",
         "32.841919",
         "32.8500026",
         "32.841919",
         "32.840688",
         "32.8387322",
         "32.840688",
         "32.7268972",
         "32.7245536"
      ]
    longPoints = [ "-117.2737146",
         "-117.2724922",
         "-117.272949",
         "-117.2515528",
         "-117.272949",
         "-117.2378148",
         "-117.2365587",
        "-117.2378148",
        "-117.1675917",
        "-117.1657617"
      ]
=end
    latPoints = [ "32.84020539999999",
         "32.841919",
      ]
    longPoints = [ "-117.2737146",
         "-117.272949",
      ]

array = Array.new
for i in 0...latPoints.size
 url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" + latPoints[i] +
  ","+longPoints[i] + "&radius=500&types=food&sensor=false&key=AIzaSyAAe8uFG4L8f_LYe-7etsNwdXraAUxIcPs"
  
  uri = URI(url)
  http = Net::HTTP.new(uri.host, uri.port)

http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
request = Net::HTTP::Get.new(uri.request_uri)

responsePlace = http.request(request)
    array.push(responsePlace.body)
end



    jsonStr = {:routes =>  ActiveSupport::JSON.decode(responseRoute.body), :place1 =>  ActiveSupport::JSON.decode(array[0]), :place2 =>  ActiveSupport::JSON.decode(array[1])}
 #return stuff

 render json: jsonStr
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
