class PlacesFinder < ActiveRecord::Base

def self.getPlaces(maxRouteBoxer,userRouteBoxer,searchString)
    #queryList = resizeBoxesToCircles(maxRouteBoxer,searchString) # setup query
    placesResults = placesQuery(maxRouteBoxer, searchString)
   # placesList = filterResults(userRouteBoxer,placesResults)
    return placesResults
end

def self.resizeBoxesToCircles(maxRouteBoxer,searchString)
    # radius in km
    maxRadius = 20

    queryList = Array.new
    # while there are boxes in maxRouteBoxer
    while( maxRouteBoxer.length > 0 )
        # pop a box
        latlngBounds = maxRouteBoxer.pop

        # calculate diagonal distance of box in km
        radiusOfEarth = 6371
        lat0 = latlngBounds[0][0] * Math::PI / 180
        lat1 = latlngBounds[1][0] * Math::PI / 180
        changeInLat = (latlngBounds[0][0]-latlngBounds[1][0]).abs * Math::PI / 180
        changeInLng = (latlngBounds[0][1]-latlngBounds[1][1]).abs * Math::PI / 180

        a = Math.sin(changeInLat/2) * Math.sin(changeInLng/2) +
            Math.cos(lat0) * Math.cos(lat1) *
            Math.sin(changeInLng/2) * Math.sin(changeInLng/2);

        c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        d = radiusOfEarth * c

        radius = d/2;
        midLat = latlngBounds[0][0] + (latlngBounds[1][0] - latlngBounds[0][0])/2
        midLng = latlngBounds[0][1] + (latlngBounds[1][1] - latlngBounds[0][1])/2

        if( radius <= maxRadius )
            queryList.push([midLat,midLng,radius*1000,searchString])
        else
            if( changeInLat > changeInLng )
                # top box
                maxRouteBoxer.push([[ midLat,latlngBounds[0][1]],
                                    [ latlngBounds[1][0], latlngBounds[1][1]]])
                # bottom box
                maxRouteBoxer.push([[ latlngBounds[0][0], latlngBounds[0][1]],
                                    [ midLat, latlngBounds[1][1]]])
            else
                # left box
                maxRouteBoxer.push([[latlngBounds[0][0],latlngBounds[0][1]],
                                    [latlngBounds[1][0],midLng]])
                # right box
                maxRouteBoxer.push([[latlngBounds[0][0],midLng],
                                    [latlngBounds[1][0],latlngBounds[1][1]]])
            end
        end
    end #while

    return queryList
end


def self.placesQuery(maxRouteBoxer, searchString)
  # query Places.getPlaces
placesList = Hash.new
  #itterate through maxRouteBoxer
  for i in 0..maxRouteBoxer.length-1
    #latitude for search
    midLat = (maxRouteBoxer[i][0][0]+maxRouteBoxer[i][1][0])/2
    #longitude for search
    midLong = (maxRouteBoxer[i][0][1]+maxRouteBoxer[i][1][1])/2

    radius = 5000

    placesListTemp =  JSON.parse(Places.findPlaces(midLat, midLong, radius, searchString))

    placesListTemp.delete("html_attributions")
    placesListTemp.delete("next_page_token")

if(!(placesList.empty?))
    placesList["results"].concat(placesListTemp)
else
  placesList = placesListTemp

end
    placesList["results"] = placesList["results"].uniq # remove duplicates


  end

  #  placesList["results"] = placesList["results"].uniq # remove duplicates

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
