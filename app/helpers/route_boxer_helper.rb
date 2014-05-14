module RouteBoxerHelper

  # Returns the full title on a per-page basis.
  def self.get_route_boxes(arrayOfRouteLocations, radius)
    #check to make sure array of Boxes is ok

    #check to make sure radius is numeric. If it isn't valid, we input our own defualt
    #screw that let google handle it
   # valid_radius = 10
    #if(numeric?(radius))
     # valid_radius = radius
    #end

    #we should probably let the user know? Nah, let google handle it
    #make the php function call and return it


    arrayOfBoxesJSON = `php app/assets/php/src/getBoxes.php #{arrayOfRouteLocations} #{radius}`
    return arrayOfBoxesJSON

    end

    def self.numeric?(object)
      true if Float(object) rescue false
    end



private
    def self.checkValidInputs(arrayOfRouteLocations, radius)
      render :json => { :errors => @model.errors }
    end
end