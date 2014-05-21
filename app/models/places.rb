class Places < ActiveRecord::Base
include PlacesHelper

  def self.getPlaces( lat, long, radius, type )
    foo = PlacesHelper.query( lat, long, radius, type )
  end
end
