class PlacesFinder < ActiveRecord::Base

def self.getPlaces(maxRouteBoxer,userRouteBoxer,params,routeLength)
    #queryList = resizeBoxesToCircles(maxRouteBoxer,searchString) # setup query
  searchString = ""
  if(defined? params[:places_filter])
searchString = params[:places_filter]
  end

  radius = 5000
  if(params.has_key? (:radius))
    radius = params[:radius].to_f/1.6
    radius *= 1000
  end

    placesResults = placesQueryAl(userRouteBoxer, searchString, radius)
    placesList = filterResults(userRouteBoxer,placesResults)
    return placesList
end



def self.placesQuery(maxRouteBoxer,userBoxer, searchString, radius, routeLength)
  placesList = Array.new
  for i in 0..maxRouteBoxer.length-1
    #latitude for search
    midLat = (maxRouteBoxer[i][0][0]+maxRouteBoxer[i][1][0])/2.0
    #longitude for search
    midLong = (maxRouteBoxer[i][0][1]+maxRouteBoxer[i][1][1])/2.0

#determine whether we should use which box?
    if(routeLength >= 8)
      placesListTemp = JSON.parse(Places.getRadarSearch(midLat, midLong, radius, searchString))
    else
    placesListTemp = JSON.parse(Places.getPlacesSearch(midLat, midLong, radius, searchString))
    end

    if(placesList.any?)
      placesList = placesListTemp
      placesList.delete("html_attributions")
      placesList.delete("next_page_token")
    else
    placesList["results"].concat (placesListTemp)["results"]
    end
  end

  placesList["results"] = placesList["results"].uniq # remove duplicates

 return JSON.generate(placesList)
end


def self.filterResults( userRouteBoxer, placesList )
    # filter for all restaurants if they're inside the user defined routeboxer
#bottomleft upperright

    i = 0
    #loop through the list of places
    while i  < placesList["results"].length
        #we assume it is not in bounds
        inBounds = true

        #itterate through the user defined boxes
        for j in 0..(userRouteBoxer.length-1)

          placesList_lat= placesList["results"][i]["geometry"]["location"]["lat"]
          placesList_long=placesList["results"][i]["geometry"]["location"]["lng"]
          #get the lat and long of the current place

          #if it is out of bounds
            if( placesList_lat < userRouteBoxer[j][1][0] &&
                placesList_lat > userRouteBoxer[j][0][0] &&
                placesList_long < userRouteBoxer[j][1][1] &&
                placesList_long > userRouteBoxer[j][0][1] )
              inBounds = false
              break
            end
        end
        #if it is not in bounds
        if inBounds == false

            placesList["results"].slice!(i)
        end
        	i = i + 1
    end


    return JSON.generate(placesList)
end
  end
