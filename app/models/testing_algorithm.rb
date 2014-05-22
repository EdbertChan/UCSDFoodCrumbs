class TestingAlgorithm < ActiveRecord::Base

def self.foo
puts("hello world")
return "this is the return"
end

def self.algorithm(maxRouteBoxer,userRouteBoxer,searchString)
    # radius in km
    maxRadius = 50
    
    queryList = Array.new
    # while there are boxes in maxRouteBoxer
    while( maxRouteBoxer.length > 0 )
    {
        # pop a box
        latlngBounds = maxRouteBoxer.pop()
    
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
        d = R * c
        
        radius = d/2;    
        midLat = latlngBounds[0][0] + (latlngBounds[1][0] - latlngBounds[0][0])/2
        midLng = latlngBounds[0][1] + (latlngBounds[1][1] - latlngBounds[0][1])/2
        
        if( radius <= maxRadius )
        {
            queryList.push([midLat,midLng,radius,searchString])
        }
        else
        {
            if( changeInLat > changeInLng )
            {
                # left box
                maxRouteBoxer.push([[ midLat,latlngBounds[0][1]],
                                    [ latlngBounds[1][0], latlngBounds[1][1]]])
                # right box
                maxRouteBoxer.push([[ latlngBounds[0][0], latlngBounds[0][1]],
                                    [ midLat, latlngBounds[1][1]]])
            }
            else
            {
                # top box
                maxRouteBoxer.push([[latlngBounds[0][0],latlngBounds[0][1]],
                                    [latlngBounds[1][0],midLng]])
                # bottom box
                maxRouteBoxer.push([[latlngBounds[0][0],midLng],
                                    [latlngBounds[1][0],latlngBounds[1][1]]])
            }
        }
    } # end while

    # query Places.getPlaces
    placesList = Array.new
    for( i = 0; i < queryList.length; i++ ) {
        placesList.push(Places.getPlaces(queryList[i][0],queryList[i][1],queryList[i][2],queryList[i][3]))
    }

    placesList = placesList.flatten(1)
    placesList = placesList.uniq

    # filter output
    for( i = 0; i < placesList.length; i++ ) {
        flag = 0
        for( j = 0; j < userRouteBoxer; j++ ) {
            if( placesList[i]["lat"] >= userRouteBoxer[j][0][0] &&
                placesList[i]["lat"] <= userRouteBoxer[j][1][0] &&
                placesList[i]["lng"] >= userRouteBoxer[j][0][1] &&
                placesList[i]["lng"] <= userRouteBoxer[j][1][1] )
            {
                flag = 1
                break
            }
        }
        if( flag == 0 ) {
            placesList.delete_at(i)
            i--;
        }
    }
end

end
