module GoogleMapsHelper

  # helper method to retrieve our uri string
  def get_url(parama)

    # set our params to variables, this makes sure we have variables set
    # incase the app sent in empty string params
    origin = parama[:origin]
    destination = parama[:destination]

    # handle nil checks incase the Application dev. does not call our app
    # correctly 
    if(origin == nil && destination == nil)
        origin = ""
        destination = ""
    elsif(origin == nil && destination != nil)
        origin = ""
    elsif(origin != nil && destination == nil)
        destination = ""
    end

    # following checks will handle the case when the app wants to do a single
    # location check
    if(origin.length == 0 && destination.length != 0)
        origin = destination
    elsif(origin.length!= 0 && destination.length == 0)
        destination = origin
    end
    
   
    url = "https://maps.googleapis.com/maps/api/directions/" +
          "json?sensor=false&origin=" + origin +
          "&destination=" + destination + "&key="+ENV["GOOGLE_API_KEY"]

    url = url.gsub(' ','_')

  end

  # GET_JSON method to retrieve json from our google
  # directions api
  def get_json(url_param)

    uri = URI(url_param)
    http = Net::HTTP.new(uri.host, uri.port)

    # enable ssl on our http request, then verify before
    # using our get call 
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)

    responseRoute = http.request(request)

    # this returns a rendered json from the body of our 
    # http request 
    jsonRoute = ActiveSupport::JSON.decode(responseRoute.body)
    jsonRoute.to_json
  end

  # will parse the string and retrieve the "status"
  def get_status(jsonRoute)

    
    # get our "status" key from the hash
    status = jsonRoute["status"]

    # determine what ERROR code to return depending on the status
    if(status == ENV["MAPS_VALID"])
      return ENV["MAPS_VALID_CODE"]
    end
    if( status== "NOT_FOUND")
      return 101
    end
    if( status=="ZERO_RESULTS")
      return 102
    end
    if(status=="MAX_WAYPOINTS_EXCEEDED")
      return 103
    end
    if(status =="INVALID_REQUEST")
      return 104
    end
    if(status =="OVER_QUERY_LIMIT")
      return 105
    end
    if(status =="REQUEST_DENIED")
      return 106
    end

    #unknown error return  

    return 107
  end

  # shall get points of each route 
  def get_points(jsonRoute)

    

    # array to hold our our collection of points
    arrayOfCoordinates = Array.new()
   


    lat = jsonRoute['routes'][0]['legs'][0]['start_location']['lat']
    lng = jsonRoute['routes'][0]['legs'][0]['start_location']['lng']

    firstPoint = Array.new()
    firstPoint.push(lat)
    firstPoint.push(lng)

    
    arrayOfCoordinates.push(firstPoint)
   
    steps = jsonRoute['routes'][0]['legs'][0]['steps']

    # go through each step
    steps.each do |step|

      
      # each step, get lat. & lng. location and push 
      lat = step["end_location"]["lat"]
      lng = step["end_location"]["lng"]
   
      endCoordinates = Array.new()
      endCoordinates.push(lat)
      endCoordinates.push(lng)
  
      arrayOfCoordinates.push(endCoordinates)
      
    end
        return arrayOfCoordinates

  end

# Helper used to convert our strings in json to an Hour value
  def time_convert(timeString)

    day=0
    hour=0
    min=0

    array = timeString.split(' ')
    array = array.to_a
    # when there is only 1 field, check which one it is
    if(array.length == 2)

      if(array[1].include?"day")
        day = array[0].to_f
      elsif(array[1].include?"hour")
        hour = array[0].to_f
      else
        min = array[0].to_f
      end

    # for 2 fields
    elsif(array.length == 4)
      if(array[1].include?"day")
        day = array[0].to_f

        if(array[3].include"hour")
          hour = array[2].to_f
        else
          min = array[2].to_f
        end
      else
        hour = array[0].to_f
        min = array[2].to_f
    # 3 fields, we know where the min/hour/day are 
    end

      day = array[0].to_f
      hour = array[2].to_f
      min = array[4].to_f

    end
   
    hour = (day*24) + hour + (min/60)

    return hour

  end
 
  # helper used to convert strings in json to a mile value
  def mile_convert(mileString)
    array = mileString.split(' ')
    miles = array[0].delete(',')
    miles = miles.to_f

    if(array[1] == "ft")
      miles = (miles/5280)
      puts("Miles of feet is #{miles}")
    end

    return miles
  end

  def get_json_time(jsonRoute, time)
    jsonRoute = JSON.parse(jsonRoute)
    params = {:origin => "", :destination => ""}

    maxTime = jsonRoute['routes'][0]['legs'][0]['duration']['text']
    maxTime = time_convert(maxTime)
   
    if(time > maxTime)
    
      lat = jsonRoute['routes'][0]['legs'][0]['end_location']['lat']
      lng = jsonRoute['routes'][0]['legs'][0]['end_location']['lng']
      origin = "#{lat},#{lng}"
      
    else
      
      timeCount = 0
      steps = jsonRoute['routes'][0]['legs'][0]['steps']
      
      steps.each do |step|
        
        stepTime = step['duration']['text']
        timeCount = timeCount + time_convert(stepTime)

        lat = step["end_location"]["lat"]
        lng = step["end_location"]["lng"]
        
        break if timeCount > time

      end
      origin = "#{lat},#{lng}"
 
    end
     
    params[:origin] = origin
    
    url = get_url(params)
    puts(url)
    json = get_json(url)
    
    return json
 
  end

  def get_json_distance(jsonRoute, distance)
    jsonRoute = JSON.parse(jsonRoute)
    params = {:origin=>"", :destination=>""}
    
    maxDist = jsonRoute['routes'][0]['legs'][0]['distance']['text']
    maxDist = mile_convert(maxDist)

    if(distance > maxDist)
   
      lat = jsonRoute['routes'][0]['legs'][0]['end_location']['lat']
      lng = jsonRoute['routes'][0]['legs'][0]['end_location']['lng']
      origin = "#{lat},#{lng}"
    else
      milesCount = 0
      steps = jsonRoute['routes'][0]['legs'][0]['steps']
      
      steps.each do |step|
        
        stepDist = step['distance']['text']
        milesCount = milesCount + mile_convert(stepDist)

        lat = step["end_location"]["lat"]
        lng = step["end_location"]["lng"]
        
        break if milesCount > distance

      end
      
      origin = "#{lat},#{lng}"
      
    end
    puts("origin is #{origin}") 
    params[:origin] = origin

    url = get_url(params)
    json = get_json(url)

    return json

  end
 
  def time_dist_check(params)
    time = params[:time]
    distance = params[:distance]

    # handle nil checks in case the Application dev. does not call our app
    # correctly 
    if(time == nil)
       time = ""
    end
    if(distance == nil)
       distance=""
    end
  
    # return value to determine which checker to call back in module
    if(time.length != 0)
       return 1;
    elsif(distance.length != 0)
       return 2;
    else
       return 0;
    end

  end

  def get_direction(jsonHash)
    return jsonHash[:routes]
  end

  def get_geostop(jsonHash)
    return jsonHash[:geoStop]

  end

end
