class GetRestaurantList < ActiveRecord::Base
  @requiredParam = ["origin"]
  #we hardcode the default parameters (I cant figure out how the hell we do this outside of the class)
  # However, this is for James. I just have this in here for you.
  @optionalParamMaps = { "destination" => nil,
                                  "sensor" => false,
                                  "mode" => "driving"
  }

  ["destination", "sensor", "mode"]
  def self.get_google_maps_direction(params)
    return get_restaurant_list_helper.
  end

  def sample_maps_template(origin, *others)
    puts ("origin is: " + origin)
    others.inspect
  end
  end
  end
