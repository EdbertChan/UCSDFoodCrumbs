class PlacesFinder < ActiveRecord::Base

def self.getPlaces(maxRouteBoxer,userRouteBoxer,searchString)
    queryList = resizeBoxesToCircles(maxRouteBoxer,searchString) # setup query
    placesResults = placesQuery(queryList)
    placesList = filterResults(userRouteBoxer,placesResults)
    return placesList
end

def self.resizeBoxesToCircles(maxRouteBoxer,searchString)
    # radius in km
    maxRadius = 50
    
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

def self.placesQuery(queryList)
    # query Places.getPlaces
    placesList = JSON.parse(Places.findPlaces(queryList[0][0],queryList[0][1],queryList[0][2],queryList[0][3]))

 placesList.delete("html_attributions")
    placesList.delete("next_page_token")
    
    for i in 1..queryList.length-1
        placesList["results"].concat (JSON.parse(Places.findPlaces(queryList[i][0],queryList[i][1],queryList[i][2],queryList[i][3])))["results"]
    end

    placesList["results"] = placesList["results"].uniq # remove duplicates

    return placesList
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
          puts(placesList_lat)
          puts(placesList_long)
          #if it is out of bounds
            if( placesList_lat <= userRouteBoxer[j][1][0] &&
                placesList_lat >= userRouteBoxer[j][0][0] &&
                placesList_long <= userRouteBoxer[j][1][1] &&
                placesList_long >= userRouteBoxer[j][0][1] )
              inBounds = false

            end
        end
        #if it is not in bounds
        if inBounds != false
            placesList["results"].slice!(i)
        end
        	i = i + 1
        end

    return JSON.generate(placesList)
end
  end
